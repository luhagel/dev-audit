require "test_helper"

require "#{Rails.root}/app/helpers/sessions_helper"
include SessionsHelper

class CanCreateDeleteTeamsTest < Capybara::Rails::TestCase
  def setup
    visit login_path

    fill_in 'Your Email Address', with: 'test@example.com'
    fill_in 'Your Password', with: 'testpw'

    click_button 'Login!'
  end

  scenario 'can add new team' do
    visit new_team_path
    page.must_have_content "Create a New Team"

    within ".new_team" do
      fill_in 'How do you want to call your Team?', with: 'Test Team'
      click_button 'Create'
    end

    page.must_have_content 'There is nothing here yet!'

    click_link 'Add'

    within '#new_developer' do
      fill_in 'Github Username', with: 'luhagel'
      click_button 'Add'
    end

    page.must_have_content "Luca Hagel"
  end

  scenario "can delete team" do
    visit new_team_path

    within ".new_team" do
      fill_in 'How do you want to call your Team?', with: 'Test Delete'
      click_button 'Create'
    end

    find('.delete-button').click
    page.must_have_content "Welcome to > dev status_"
  end

  def teardown
    visit root_path
    within '#sidenav' do
      click_link 'Logout'
    end
  end
end
