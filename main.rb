#!/usr/bin/env ruby

# Installs dependencies
require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'glimmer-dsl-libui'
  gem 'dotenv'
end
#

# External and Internal Dependencies
require 'glimmer-dsl-libui'
require 'dotenv'
require 'uri'
require 'net/http'
require 'json'
require_relative 'config'
require_relative 'data_fetcher'
require_relative 'ui_elements'
require_relative 'event_handlers'

# Configuration and Environment Variables
Dotenv.load

# Include Modules
include Glimmer
include UIElements

# Data Initialization
currencies = CURRENCIES.join('%2C%20')
updated_data = get_data(currencies, 'USD')

# Application Window
window('Currency Converter', 600, 500) {
  vertical_box {
    table_component(updated_data)
    search_entry_component(updated_data)
  }
}.show
