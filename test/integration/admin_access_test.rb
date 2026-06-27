# frozen_string_literal: true

require "test_helper"

class AdminAccessTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "guests are redirected to sign in" do
    get admin_root_path

    assert_redirected_to new_user_session_path
  end

  test "non-admins are denied and redirected to root with an alert" do
    sign_in users(:member)
    get admin_root_path

    assert_redirected_to root_path
    follow_redirect!
    assert_match(/not authorized/i, response.body)
  end

  test "admins can reach the dashboard" do
    sign_in users(:admin)
    get admin_root_path

    assert_response :success
    assert_select "h1", text: "Dashboard"
  end
end
