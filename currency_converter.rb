# docs: https://github.com/AndyObtiva/glimmer-dsl-libui#area-text
# API Key
# https://apilayer.com/marketplace/exchangerates_data-api

require 'glimmer-dsl-libui'
require 'dotenv'
require 'uri'
require 'net/http'
require'json'

Dotenv.load
include Glimmer


# DATA
currencies = ['USD', 'EUR', 'SEK', 'JPY', 'KRW']
currencies = currencies.join("%2C%20")
data = []
def get_data(currencies)
  url = URI("https://api.apilayer.com/exchangerates_data/latest?symbols=#{currencies}&base=USD")

  https = Net::HTTP.new(url.host, url.port);
  https.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request['apikey'] = ENV['API_KEY']

  response = https.request(request)
  response_hash = JSON.parse(response.body)

  # för varje key skapa en ny array och ta med värdet.
  # släng sen in en 0:a i slutet.

  response_hash["rates"].each do |currency, rate|
    item = [currency, rate, 0]
    data.append(item)
  end
  puts data.inspect
end

# APP

get_data(currencies)

window('Currency Converter', 600, 500) {
  vertical_box {
    table {
      text_column('Currency')
      text_column('Market Value')
      text_column('Converted Value')

       cell_rows data
    }

    search_entry { |value|
      stretchy false

      on_changed do
        new_value = value.text
        new_data ||= data.dup

        # Loopa över alla valutor
        # Byta ut värdet på valuta[2] till ett nytt värde
        # Uppdatera värdena i orginal-data
        new_data.each do |currency|
          currency[1] = 0
          new_total = (currency[1]) + new_value.to_i * currency[0]
          currency[1] = new_total.round(1)
        end
      end
    }
  }
}.show
