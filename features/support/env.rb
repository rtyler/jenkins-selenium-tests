#!/usr/bin/env ruby
# vim: tabstop=2 expandtab shiftwidth=2

require 'capybara/cucumber'
require 'capybara/session'
require 'selenium-webdriver'

Capybara.register_driver :selenium do |app|
  http_client = Selenium::WebDriver::Remote::Http::Default.new
  http_client.timeout = 120
  Capybara::Selenium::Driver.new(app, :browser => :firefox, :http_client => http_client)
end

Capybara.run_server = false
Capybara.default_selector = :css
Capybara.default_driver = :selenium


# Include Page objects:

PAGE_OBJECTS_BASE = File.dirname(__FILE__) + "/../../lib/"


Dir["#{PAGE_OBJECTS_BASE}/*.rb"].each do |name|
  require File.expand_path(name)
end
