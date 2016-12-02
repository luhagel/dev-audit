require 'test_helper'

class DevelopersControllerTest < ActionDispatch::IntegrationTest
  test "should get index," do
    get developers_index,_url
    assert_response :success
  end

  test "should get new," do
    get developers_new,_url
    assert_response :success
  end

  test "should get create," do
    get developers_create,_url
    assert_response :success
  end

  test "should get show" do
    get developers_show_url
    assert_response :success
  end

end
