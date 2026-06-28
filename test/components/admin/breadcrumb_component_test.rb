# frozen_string_literal: true

require "test_helper"

class Admin::BreadcrumbComponentTest < ViewComponent::TestCase
  def test_collection_edit_links_back_through_the_trail
    render_inline(Admin::BreadcrumbComponent.new(controller_name: "testimonials", action_name: "edit"))

    assert_selector "nav[aria-label='breadcrumb']"
    assert_link "Dashboard", href: "/admin"
    assert_link "Testimonials", href: "/admin/testimonials"
    assert_selector "li.breadcrumb-item.active", text: "Edit"
  end

  def test_singleton_section_is_the_active_crumb
    render_inline(Admin::BreadcrumbComponent.new(controller_name: "hero_contents", action_name: "edit"))

    assert_link "Dashboard", href: "/admin"
    assert_selector "li.breadcrumb-item.active", text: "Hero"
    assert_no_link "Hero"
  end

  def test_hidden_on_the_dashboard
    render_inline(Admin::BreadcrumbComponent.new(controller_name: "dashboard", action_name: "show"))

    assert_no_selector "nav[aria-label='breadcrumb']"
  end
end
