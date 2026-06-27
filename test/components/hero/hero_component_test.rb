# frozen_string_literal: true

require "test_helper"

class Hero::HeroComponentTest < ViewComponent::TestCase
  def test_renders_title_tagline_and_primary_udemy_cta
    render_inline(Hero::HeroComponent.new)

    assert_selector("section.site-hero h1", text: Site::COURSE)
    assert_text(Site::TAGLINE)
    assert_link("Enroll on Udemy", href: Site::UDEMY_URL, minimum: 1)
  end

  def test_cta_opens_in_a_new_tab_safely
    render_inline(Hero::HeroComponent.new)

    assert_selector("a.btn-brand[href='#{Site::UDEMY_URL}'][target='_blank'][rel~='noopener']", minimum: 1)
  end

  def test_accepts_custom_title_and_cta
    render_inline(Hero::HeroComponent.new(title: "Custom Title", cta_text: "Buy now", cta_url: "https://example.com"))

    assert_selector("h1", text: "Custom Title")
    assert_link("Buy now", href: "https://example.com")
  end
end
