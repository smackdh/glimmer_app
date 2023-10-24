module EventHandlers
  def on_search_entry_changed(value, updated_data)
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
  end
end
