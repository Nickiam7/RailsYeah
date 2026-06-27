# frozen_string_literal: true

require "test_helper"

class Admin::NavComponentTest < ViewComponent::TestCase
  def test_renders_brand_section_links_view_site_and_sign_out
    render_inline(Admin::NavComponent.new(user_email: "admin@example.com"))

    assert_selector("nav.navbar")
    assert_link("Dashboard", href: "/admin")
    assert_link("Hero")
    assert_link("View site", href: "/")
    assert_link("Sign out", href: "/users/sign_out")
    assert_text("admin@example.com")
  end
end
