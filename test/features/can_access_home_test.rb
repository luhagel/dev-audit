require "test_helper"

class CanAccessHomeTest < Capybara::Rails::TestCase
  scenario "has content" do
    visit root_path
    page.must_have_content "Welcome to > dev status_"
  end
end
