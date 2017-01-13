require "test_helper"

class CanAccesErrorPagesTest < Capybara::Rails::TestCase
  scenario "can access 404" do
    visit '/404'
    page.must_have_content '404'
  end

  scenario "can access 500" do
    visit '/500'
    page.must_have_content '500'
  end
end
