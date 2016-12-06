require "#{Rails.root}/app/helpers/developers_helper"
include DevelopersHelper

desc "This task is called by the Heroku scheduler add-on"
task :refresh_dev_data => :environment do
  puts "Updating feed..."
  updateAllDeveloperInfo()
  puts "done."
end