Capybara.server = :puma, { Silent: true }

Capybara.register_driver :chrome_headless do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new

  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1400,1400')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :chrome_headless

# Setup rspec
RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :chrome_headless
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
#     Capybara.javascript_driver = :headless_chrome
#     # driven_by :selenium_remote
#     # host! "http://#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}"
#   end

# end