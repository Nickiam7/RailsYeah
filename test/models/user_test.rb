require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "admin defaults to false" do
    assert_not User.new.admin?
  end

  test "requires an email and a password" do
    user = User.new
    assert_not user.valid?
    assert_includes user.errors.attribute_names, :email
    assert_includes user.errors.attribute_names, :password
  end

  test "fixtures load an admin and a non-admin" do
    assert users(:admin).admin?
    assert_not users(:member).admin?
  end
end
