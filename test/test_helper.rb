ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start 'rails' unless ENV['NO_COVERAGE']

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'minitest/rails/capybara'

require 'minitest/reporters'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  @testuser = User.new
  @testuser.name="testaccount"
  @testuser.email="testaccount@example.com"
  @testuser.password="testpw"
  @testuser.password_confirmation="testpw"
  @testuser.save
end
