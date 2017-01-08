require "test_helper"

class CanRegisterTest < Capybara::Rails::TestCase
  scenario "can click register button" do
    visit root_path
    click_on 'Register'
    page.must_have_content 'Login instead'
  end

  scenario "user enters valid input" do
    visit signup_path

    within '#new_user' do
      fill_in 'Your Name', with: 'Name'
      fill_in 'Your Email Address', with: 'testsuite@example.com'
      fill_in 'Pick a Strong Password', with: 'testpw'
      fill_in 'Password Confirmation', with: 'testpw'

      click_button 'Register!'
    end

    page.must_have_content 'Welcome to Dev Audit!'
  end

  scenario "user enters invalid input" do
    visit signup_path

    within '#new_user' do
      fill_in 'Your Name', with: 'Name'
      fill_in 'Your Email Address', with: 'testsuite@example.com'
      fill_in 'Pick a Strong Password', with: 'testpw'
      fill_in 'Password Confirmation', with: ''

      click_button 'Register!'
    end

    page.must_have_content 'Something went wrong!'
  end
end
