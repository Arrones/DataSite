require "selenium-webdriver"
require "test/unit"

class SeleniumRubyTest < Test::Unit::TestCase
@@driver

def setup
# create Driver object for Chrome
@@driver = Selenium::WebDriver.for :chrome
# Navigate to URL
@@driver.navigate.to "https://www.uhaul.com/"
@@menuItemText = "Storage"
@@subMenuItemText = "Move-In Online Today!"
end

def test_menu_item_selection
@@driver.manage.timeouts.implicit_wait = 5 # seconds
# Find the main menu element using driver object
menu = @@driver.find_element(:id, "mainHeaderMenu").find_element(:xpath, ".//*[contains(., '" + @@menuItemText + "')]")
@@driver.action.move_to(menu).perform
#Find submenu item
submenu = @@driver.find_element(:id, "smStorage").find_element(:xpath, ".//*[contains(., '" + @@subMenuItemText + "')]").click
wait = Selenium::WebDriver::Wait.new(timeout: 20)
onlineMoveIn = @@driver.find_element(:id, "OnlineMoveIn").attribute('value')
# Assert in the types of Storage Online Move-In is selected
assert_equal(onlineMoveIn, "true")
end

def teardown
# Quit the driver
@@driver.quit
end

end