require "capybara/cucumber"
require "selenium-webdriver"
require "faker"

Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :selenium_chrome
  config.app_host = "http://takehome.zeachable.com"
end
