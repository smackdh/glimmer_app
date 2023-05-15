# docs: https://github.com/AndyObtiva/glimmer-dsl-libui#area-text
require 'glimmer-dsl-libui'

include Glimmer

data = [
  ['USD', 10, 0],
  ['SEK', 1, 0],
  ['JPY', 0.1, 0],
]

window('Currency Converter', 600, 500) {
  vertical_box {
    table {
      text_column('Currency')
      text_column('Current Value')
      text_column('Converted Value')

       cell_rows data
    }

    button('Calculate') {
      stretchy false
      on_clicked do
        puts "Click click"
      end
    }

  }
}.show
