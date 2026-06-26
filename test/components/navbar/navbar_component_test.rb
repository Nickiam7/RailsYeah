# frozen_string_literal: true

require "test_helper"

class Navbar::NavbarComponentTest < ViewComponent::TestCase
  def test_renders_brand_responsive_toggle_links_and_udemy_cta
    render_inline(Navbar::NavbarComponent.new)

    assert_selector("nav.navbar.navbar-expand-lg")
    assert_selector("a.navbar-brand", text: Site::NAME)
    assert_selector("button.navbar-toggler") # responsive hamburger
    assert_selector(".navbar-nav .nav-link", minimum: 1)
    assert_link("Enroll on Udemy", href: Site::UDEMY_URL)
  end

  def test_accepts_custom_links
    links = [ Navbar::NavbarComponent::Link.new("Pricing", "#pricing") ]
    render_inline(Navbar::NavbarComponent.new(links: links))

    assert_link("Pricing", href: "#pricing")
    assert_no_link("Curriculum")
  end
end
