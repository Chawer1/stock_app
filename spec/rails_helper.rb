# This file is copied to spec/ when you run 'rails generate rspec:install'
require File.expand_path("../../config/environment", __FILE__)
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rspec'
require 'selenium/webdriver'

# Configure RSpec
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

# Configure Capybara to use Selenium with Chrome headless browser
Capybara.register_driver :chrome_headless do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--disable-gpu')
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

# Use Chrome headless for JavaScript-enabled tests
Capybara.javascript_driver = :chrome_headless
