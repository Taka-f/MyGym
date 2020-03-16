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
# RSpec.configure do |config|
#   config.before(:each, type: :system) do
#     driven_by :rack_test
#   end

#   config.before(:each, type: :system, js: true) do
#     if ENV["SELENIUM_DRIVER_URL"].present?
#       driven_by :selenium, using: :chrome,
#                            options: {
#                                browser: :remote,
#                                url: ENV.fetch("SELENIUM_DRIVER_URL"),
#                                desired_capabilities: :chrome}
#     else
#       driven_by :selenium_chrome_headless
#     end
#   end
# end
# Capybara.register_driver :chrome do |app|
#   Capybara::Selenium::Driver.new(app, browser: :chrome)
# end

# Capybara.register_driver :headless_chrome do |app|
#   capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
#     chromeOptions: { args: %w(headless no-sandbox) }
#   )

#   if ENV['SELENIUM_DRIVER_URL'].present?
#     Capybara::Selenium::Driver.new(
#       app,
#       browser: :remote,
#       url: ENV.fetch('SELENIUM_DRIVER_URL'),
#       desired_capabilities: capabilities
#     )   
#   else
#     Capybara::Selenium::Driver.new app,
#       browser: :chrome,
#       desired_capabilities: capabilities
#   end 
# end

# Capybara.javascript_driver = :headless_chrome
# ----------------------------------
Capybara.server_host = Socket.ip_address_list.detect{|addr| addr.ipv4_private?}.ip_address
Capybara.server_port = 4444

Capybara.register_driver :selenium_remote do |app|
  url = "http://chrome:4444/wd/hub"
  opts = { desired_capabilities: :chrome, browser: :remote, url: url }
  driver = Capybara::Selenium::Driver.new(app, opts)
end

RSpec.configure do |config|

  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium_remote
    host! "http://#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}"
  end

end