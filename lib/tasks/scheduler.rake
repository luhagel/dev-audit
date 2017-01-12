require "#{Rails.root}/app/helpers/github_users_helper"
include GithubUsersHelper

desc 'This task is called by the Heroku scheduler add-on'
task refresh_dev_data: :environment do
  puts 'Updating feed...'
  update_all_developer_info
  puts 'done.'
end
