require "capybara/playwright"

Capybara.register_driver(:playwright) do |app|
  Capybara::Playwright::Driver.new(app,
    browser_type: :chromium,
    headless: true
  )
end

Capybara.default_driver = :playwright
Capybara.javascript_driver = :playwright
Capybara.server_host = "0.0.0.0"

Capybara.save_path = Rails.root.join("tmp/capybara")

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :playwright
  end
end
