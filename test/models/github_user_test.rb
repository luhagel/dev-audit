require 'test_helper'

class GithubUserTest < ActiveSupport::TestCase
  def setup
    @github_user = github_users(:octocat)
  end

  test "should be valid" do
    assert @github_user.valid?
  end

  test "should have login" do
    @github_user.login = ""
    assert_not @github_user.valid?
  end

  test "should have developer_id" do
    @github_user.developer_id = nil
    assert_not @github_user.valid?
  end
end
