require 'selenium-webdriver'

module Gurzu

  class GoogleSearch

    SELENIUM_DRIVER_PATH = '/home/shishir/Documents/chrome-driver/chromedriver'.freeze
    GOOGLE_URL = 'https://google.com'.freeze
    SLEEP_TIME = 5

    def initialize(url, value)
      @driver = chrome_driver
      @url = url
      @value = value
    end

    # #
    # open google chrome
    # type value text
    # search text
    # and click if the url is found
    #
    # returns(array) suggestions given by search engine
    # #
    def process
      type_value
      suggestions = grab_suggestions
      submit_value
      click_url

      suggestions
    end

    def search
      type_value
      submit_value
    end

    def suggestions
      type_value
      grab_suggestions
    end

    def visit_url
      type_value
      submit_value
      click_url
    end

    private

    def chrome_driver
      Selenium::WebDriver::Chrome.driver_path = SELENIUM_DRIVER_PATH
      Selenium::WebDriver.for :chrome
    end

    def type_value
      @driver.navigate.to GOOGLE_URL
      @driver.find_element(:name, 'q').send_keys(@value)

      sleep SLEEP_TIME

    end

    def submit_value
      @driver.find_element(:name, 'btnK').click

      sleep SLEEP_TIME
    end

    def grab_suggestions
      @driver.find_elements(:xpath, "//ul[@class='erkvQe']//li//span[text()]")
             .map(&:text)
    end

    def click_url
      results = @driver.find_elements(:xpath, "//div[@id='rso']//div[@class='yuRUbf']/a")
      link = results.detect { |result| result.attribute('href') == @url }

      !link.nil? ? link.click : (p 'No result found')
    end

  end
end

# Gurzu::GoogleSearch.new('https://gurzu.com/', 'Gurzu').search # search given keyword in google chorme
# puts Gurzu::GoogleSearch.new('https://gurzu.com/', 'Gurzu').suggestions # returns array of suggestions
# Gurzu::GoogleSearch.new('https://gurzu.com/', 'Gurzu').visit_url # visits given url
puts Gurzu::GoogleSearch.new('https://gurzu.com/', 'gurzu').process # all of the above. returns array of suggestions