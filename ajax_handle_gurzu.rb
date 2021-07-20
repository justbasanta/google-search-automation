require 'selenium-webdriver'

Selenium::WebDriver::Chrome.driver_path="/home/shishir/Documents/chrome-driver/chromedriver"
# caps = Selenium::WebDriver::Remote::Capabilities.chrome("goog:chromeOptions" => {"args" => ['disable-notifications']})

driver = Selenium::WebDriver.for :chrome
$url = "https://google.com"

driver.navigate.to $url

driver.find_element(:name, 'q').send_keys("Gurzu")
sleep 5

all_suggestions = driver.find_elements(:xpath, "//ul[@class='erkvQe']//li//span[text()]")

all_suggestions.each do |x|
  puts x.text
end

driver.find_element(:name, 'btnK').click

sleep 5

all_search_results = driver.find_elements(:xpath, "//div[@id='rso']//div[@class='yuRUbf']/a")

all_search_results.each do |x|
  # puts x.attribute("href")
  if x.attribute("href") == "https://gurzu.com/"
    x.click
    break
  else
    puts "No result found !!!"
  end
end