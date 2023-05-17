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

data = [
  [1, 0],
  [0.923466, 0],
  [10.45, 0],
  [137.271, 0],
  [1336.50, 0],
]

currencies = ['USD', 'EUR', 'SEK', 'JPY', 'KRW']
currencies = currencies.join("%2C%20")

def get_data(currencies)
  url = URI("https://api.apilayer.com/exchangerates_data/latest?symbols=#{currencies}&base=USD")

  https = Net::HTTP.new(url.host, url.port);
  https.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request['apikey'] = ENV['API_KEY']

  response = https.request(request)
  puts response.body
end

# APP

window('Currency Converter', 600, 500) {
  vertical_box {
    table {
      text_column('Currency')
      text_column('Market Value')
      text_column('Converted Value')

       cell_rows data
    }

    get_data(currencies)

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
