require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  def setup
    @test_user = users(:one)
  end
  
  test "Only allows valid teams" do
    valid_team = Team.create(name: "testteam", user: @test_user)
    invalid_team = Team.create(name: "testteam2")

    assert valid_team.valid?
    assert !invalid_team.valid?
  end
end
