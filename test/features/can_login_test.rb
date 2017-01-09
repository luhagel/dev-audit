require "test_helper"

class CanLoginTest < Capybara::Rails::TestCase
  scenario "can click login button" do
    visit root_path
    within '#sidenav' do
      click_on 'Login'
    end
    page.must_have_content 'No Account?'
  end

  scenario "user enters valid input" do
    visit login_path

    fill_in 'Your Email Address', with: 'test@example.com'
    fill_in 'Your Password', with: 'testpw'

    click_button 'Login!'

    page.must_have_content 'Hey TestUser'
  end

  scenario "user enters invalid input" do
    visit login_path

    fill_in 'Your Email Address', with: 'test@example.com'
    fill_in 'Your Password', with: 'MARA1337'

    click_button 'Login!'

    page.must_have_content 'Invalid email/password combination'
  end
end
