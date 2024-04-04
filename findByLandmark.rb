require "selenium-webdriver"
require "test/unit"

class SeleniumRubyTest < Test::Unit::TestCase
@@driver

# TC-004

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
#inputLocation.send_keys("New York, NY")
inputLocation.send_keys("Statue of Liberty")
button = @@driver.find_element(:xpath => "//*[@class='expanded' and contains(text(),'Find Storage')]").click
wait = Selenium::WebDriver::Wait.new(timeout: 20)
# Wait until the element is displayed
# Wait for the condition
wait.until { @@driver.find_element(:id, "movingFromInput").attribute('value') == "New York, NY" }
actualValue = @@driver.find_element(:id, "movingFromInput")['value']
# Assert the expected text with actual text
assert_equal(actualValue, "New York, NY")
end

def teardown
# Quit the driver
@@driver.quit
end

end