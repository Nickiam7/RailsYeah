# frozen_string_literal: true

require "test_helper"

class AuthenticationTest < ActionDispatch::IntegrationTest
  setup { @admin = users(:admin) } # fixture password: "password123456"

  test "the sign-in page renders" do
    get new_user_session_path

    assert_response :success
    assert_select "form[action=?]", user_session_path
  end

  test "valid credentials sign the user in" do
    sign_in_as(@admin, "password123456")

    assert_redirected_to root_path
    follow_redirect!
    assert_match(/signed in successfully/i, response.body)
  end

  test "invalid credentials are rejected" do
    sign_in_as(@admin, "wrong-password")

    assert_match(/invalid email or password/i, response.body)
  end

  test "a signed-in user can sign out" do
    sign_in_as(@admin, "password123456")
    delete destroy_user_session_path

    assert_redirected_to root_path
    follow_redirect!
    assert_match(/signed out successfully/i, response.body)
  end

  test "public registration is disabled (no sign-up route)" do
    assert_not Rails.application.routes.url_helpers.respond_to?(:new_user_registration_path),
               "expected Devise registration routes to be disabled"
  end

  private

  def sign_in_as(user, password)
    post user_session_path, params: { user: { email: user.email, password: password } }
  end
end
