require "#{Rails.root}/app/helpers/developers_helper"
include DevelopersHelper

desc 'Check wether accounts with the same username exist'
task crawl_dev_usernames: :environment do
  puts 'Checking usernames...'
  find_account_matches
  puts 'done.'
end
