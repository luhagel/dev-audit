require 'test_helper'

class DeveloperTest < ActiveSupport::TestCase
  def setup
    @test_team = teams(:team1)
    @test_dev = developers(:octocat)
  end

  test "should be valid" do
    assert @test_dev.valid?
  end

  test "should have a username" do
    @test_dev.username = nil
    assert_not @test_dev.valid?
  end
end
