# docs: https://github.com/AndyObtiva/glimmer-dsl-libui#area-text
# API Key
# https://apilayer.com/marketplace/exchangerates_data-api

require 'glimmer-dsl-libui'
require 'dotenv'

Dotenv.load
include Glimmer

data = [
  ['USD', 1, 0],
  ['EUR', 0.923466, 0],
  ['SEK', 10.45, 0],
  ['JPY', 137.271, 0],
  ['WON', 1336.50, 0],
]

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
          currency[2] = 0
          new_total = (currency[2]) + new_value.to_i * currency[1]
          currency[2] = new_total.round(2)
        end
      end
    }
  }
}.show
