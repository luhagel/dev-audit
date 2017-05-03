require "#{Rails.root}/app/helpers/github_users_helper"
include GithubUsersHelper

desc 'This task scrapes the languages of a users pinned repos'
task fetch_dev_langs: :environment do
  puts 'Updating feed...'
  get_prefered_languages 'luhagel'
  puts 'done.'
end
