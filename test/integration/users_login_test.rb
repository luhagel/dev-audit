require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  test "login with invalid information" do
    get login_path
    assert_response :success
    post login_path, params: { session: { email: "j", password: "k" } }
    assert_response :success
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information" do
    get login_path
    assert_response :success
    post login_path, params: { session: { email: "testaccount@example.com", password: "testpw" } }
    assert_response :success
    assert_not flash.empty?
  end
end
