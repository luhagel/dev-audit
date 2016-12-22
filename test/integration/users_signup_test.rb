require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "signup with invalid information" do
    get signup_path
    assert_response :success
    post users_path, params: { user: {name: "test_signup", 
                                    email: "test_signup@example.com", 
                                    password: "testpw", 
                                    password_confirmation: "testpvv"} }
    assert_not flash.empty?
  end

  test "signup with valid information" do
    get signup_path
    assert_response :success
    post users_path, params: { user: {name: "test_signup", 
                                    email: "test_signup@example.com", 
                                    password: "testpw", 
                                    password_confirmation: "testpw"} }
    assert_redirected_to teams_path
  end
end
