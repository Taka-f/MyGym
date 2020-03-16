# require 'capybara/rspec'

# RSpec.configure do |config|
#   config.before(:each, type: :system) do
#     driven_by :selenium, using: :headless_chrome, options: {
#       browser: :remote,
#       url: ENV.fetch("SELENIUM_DRIVER_URL"),
#       desired_capabilities: :chrome
#     }
#     Capybara.server_host = 'web'
#     Capybara.app_host='http://web'
#   end
# end

# RSpec.configure do |config|
#   config.before(:each, type: :system) do
#     driven_by :rack_test
#   end

#   config.before(:each, type: :system, js: true) do
#     driven_by :selenium_chrome_headless
#   end
# end
Capybara.register_driver :headless_chrome do |app|
  browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
    opts.args << "--headless"
    opts.args << "--disable-gpu"
    opts.args << "--no-sandbox"
  end
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    if ENV["SELENIUM_DRIVER_URL"].present?
      driven_by :selenium, using: :chrome,
                           options: {
                               browser: :remote,
                               url: ENV.fetch("SELENIUM_DRIVER_URL"),
                               desired_capabilities: :chrome}
    else
      # driven_by :selenium_chrome_headless
      driven_by :headless_chrome
    end
  end
end
# ----------------------------------
# Capybara.server_host = Socket.ip_address_list.detect{|addr| addr.ipv4_private?}.ip_address
# Capybara.server_port = 4444

# Capybara.register_driver :selenium_remote do |app|
#   url = "http://chrome:4444/wd/hub"
#   opts = { desired_capabilities: :chrome, browser: :remote, url: url }
#   driver = Capybara::Selenium::Driver.new(app, opts)
# end

# RSpec.configure do |config|

#   config.before(:each, type: :system) do
#     driven_by :rack_test
#   end

#   config.before(:each, type: :system, js: true) do
#     driven_by :selenium_chrome_headless
#     # driven_by :selenium_remote
#     # host! "http://#{Capybara.server_host}:#{Capybara.server_port}"
#   end

# end



# require "selenium/webdriver"
# Capybara.register_driver :selenium_chrome_in_container do |app|
#   Capybara::Selenium::Driver.new app,
#   browser: :remote,
#   url: "http://selenium_chrome:4444/wd/hub",
#   desired_capabilities: :chrome
# end


# RSpec.configure do |config|
#   config.before(:each, type: :system, js: true) do
#     driven_by :selenium_chrome_in_container
#     # Capybara.server_host = "0.0.0.0"
#     # Capybara.server_port = 3000
#     # Capybara.app_host = 'http://web:4000'
#     Capybara.server_port = 4444
#     Capybara.app_host = "http://127.0.0.1:4444/"
#   end
# end