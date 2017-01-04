require 'test_helper'

class ErrorsControllerTest < ActionDispatch::IntegrationTest
  test "should get not_found" do
    get "/404"
    assert_template "not_found"
  end

  test "should get internal_server_error" do
    get "/500"
    assert_template "internal_server_error"
  end

end
