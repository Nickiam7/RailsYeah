# frozen_string_literal: true

require "application_system_test_case"

class AdminDashboardTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  setup { Warden.test_mode! }
  teardown { Warden.test_reset! }

  test "an admin sees the dashboard in the dedicated admin layout" do
    login_as users(:admin), scope: :user
    visit admin_root_path

    assert_selector "h1", text: "Dashboard"
    assert_text "Course Admin"               # admin nav (not the marketing navbar)
    assert_text "Hero"                       # content-section card
    assert_no_selector "footer.site-footer"  # admin layout drops the marketing chrome
  end

  test "a non-admin is denied access to the admin area" do
    login_as users(:member), scope: :user
    visit admin_root_path

    assert_current_path root_path
    assert_text "not authorized"
  end
end
