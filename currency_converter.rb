require 'glimmer-dsl-libui'

include Glimmer

data = [
  ['USD', 10, 0],
  ['SEK', 1, 0]
]

window('Currency Converter', 300, 200) {
  vertical_box {
    table {
      text_column('Currency')
      text_column('Current Value')
      text_column('Converted Value')
    }

    cell_rows data
  }
}.show
