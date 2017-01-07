require 'test_helper'

class DeveloperTest < ActiveSupport::TestCase
  def setup
    @test_user = users(:one)
    @test_team = Team.create(name: "Test Team", user: @test_user)
  end
end
