require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
  def setup
    @membership = memberships(:one)
  end

  test "should be valid" do
    assert @membership.valid?
  end

  test "should have developer" do
    @membership.developer_id = nil
    assert_not @membership.valid?
  end

  test "should have team" do
    @membership.team_id = nil
    assert_not @membership.valid?
  end
end
