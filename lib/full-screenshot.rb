require 'selenium-webdriver'
require "full-screenshot/version"
require "full-screenshot/extentions/full_screenshot"
require "oily_png"

module Selenium
  module WebDriver
    module Chrome
      class Bridge
        alias_method :orig_driver_extensions, :driver_extensions
        def driver_extensions
          orig_driver_extensions + [
            DriverExtensions::FullScreenshot
          ]
        end
      end
    end
    module Firefox
      class W3CBridge
        alias_method :orig_driver_extensions, :driver_extensions
        def driver_extensions
          orig_driver_extensions + [
            DriverExtensions::FullScreenshot
          ]
        end
      end
    end
  end
end
