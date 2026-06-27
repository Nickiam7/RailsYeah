# frozen_string_literal: true

require "test_helper"

class AdminPolicyTest < ActiveSupport::TestCase
  test "admins are granted access" do
    assert AdminPolicy.new(users(:admin), :admin).access?
  end

  test "non-admins are denied access" do
    assert_not AdminPolicy.new(users(:member), :admin).access?
  end

  test "guests are denied access" do
    assert_not AdminPolicy.new(nil, :admin).access?
  end
end
