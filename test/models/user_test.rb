require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "Only allows valid users" do
    valid_user = users(:one)
    invalid_user = User.create()

    assert valid_user.valid?
    assert !invalid_user.valid?
  end 
end
