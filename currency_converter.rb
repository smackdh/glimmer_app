# Requirements
require 'glimmer-dsl-libui'
require 'dotenv'
require 'uri'
require 'net/http'
require 'json'

Dotenv.load
include Glimmer

# DATA
currencies = ['USD', 'EUR', 'SEK', 'JPY', 'KRW']
base_values = ['USD', 'EUR', 'SEK', 'JPY', 'KRW']
currencies = currencies.join('%2C%20')

def get_data(currency_array, base)
  data = []
  url = URI("https://api.apilayer.com/exchangerates_data/latest?symbols=#{currency_array}&base=USD")

  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request['apikey'] = ENV['API_KEY']

  response = https.request(request)
  response_hash = JSON.parse(response.body)

  response_hash['rates'].each do |currency, rate|
    item = [currency, rate, 0]
    data.append(item)
  end
  data
end

# Fetches the exchange rate for each currency to USD.
updated_data = get_data(currencies, 'USD')

# Creates the application window
window('Currency Converter', 600, 500) {
  vertical_box {
    table {
      text_column('Currency')
      text_column('Market Value')
      text_column('Converted Value')

       cell_rows updated_data
    }

    # Input Field
    search_entry { |value|
      stretchy false

      # Action on input
      on_changed do
        new_value = value.text
        new_data ||= updated_data.dup

        # Iterates over each of the currencies added, and replaces the default "0" with the actual value.
        new_data.each do |currency|
          currency[2] = 0
          new_total = (currency[2]) + new_value.to_i * currency[1]
          currency[2] = new_total.round(2)
        end
      end
    }
  }
}.show
