require "selenium-webdriver"
require "test/unit"

class SeleniumRubyTest < Test::Unit::TestCase
@@driver

def setup
# create Driver object for Chrome
@@driver = Selenium::WebDriver.for :chrome
# Navigate to URL
@@driver.navigate.to "https://www.uhaul.com/Storage/"
end

def test_find_by_zip_code
@@driver.manage.timeouts.implicit_wait = 10 # seconds
# Find the element using driver object
inputLocation = @@driver.find_element(:id, "movingFromInput")
inputLocation.send_keys("33122")
wait = Selenium::WebDriver::Wait.new(timeout: 30)
wait.until { @@driver.find_element(class: "ui-menu-item").displayed? }
autocomplete_result = @@driver.find_element(:class, "ui-menu-item").click
button = @@driver.find_element(:xpath => "//*[@class='expanded' and contains(text(),'Find Storage')]").click
wait = Selenium::WebDriver::Wait.new(timeout: 5)
# Wait until the element is displayed
# Wait for the condition
wait.until { @@driver.find_element(:id, "movingFromInput").attribute('value') == "33122" }
actualValue = @@driver.find_element(:id, "movingFromInput")['value']
#.attribute('value')  
# Assert the expected text with actual text
assert_equal(actualValue, "33122")
end

def teardown
# Quit the driver
@@driver.quit
end

end