require 'test_helper'

class DeveloperTest < ActiveSupport::TestCase
  def setup
    @test_user = users(:one)
    @test_team = Team.create(name: "Test Team", user: @test_user)
  end
  
  test "Only allows valid developers" do
    valid_developer = Developer.create(name: "testuser", username: "octocat", team: @test_team)
    invalid_developer = Developer.create(name: "testuser2")

    assert valid_developer.valid?
    assert !invalid_developer.valid?
  end
end
