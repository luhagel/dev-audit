require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  def setup
    @team = teams(:team1)
  end

  test "should be valid" do
    assert @team.valid?
  end

  test "should have name" do
    @team.name = ""
    assert_not @team.valid?
  end

  test "should have user" do
    @team.user_id = nil
    assert_not @team.valid?
  end
end
