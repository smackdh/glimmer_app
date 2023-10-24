
require_relative 'event_handlers'
include EventHandlers

module UIElements
  def table_component(updated_data)
    table {
      text_column('Currency')
      text_column('Market Value')
      text_column('Converted Value')
      cell_rows updated_data
    }
  end

  def search_entry_component(updated_data)
    # Input Field
    search_entry { |value|
      stretchy false
    on_search_entry_changed(value, updated_data)
    }
  end

end
