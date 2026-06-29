# frozen_string_literal: true

require "test_helper"

class Hero::CardHeroComponentTest < ViewComponent::TestCase
  def test_renders_title_preview_card_and_stats
    render_inline(Hero::CardHeroComponent.new)

    assert_selector "section.site-hero h1", text: Site::COURSE
    assert_selector ".course-card .hero-preview"
    assert_selector ".course-stat-row", count: 4
    assert_link "Enroll on Udemy", href: Site::UDEMY_URL, minimum: 1
  end

  def test_accepts_custom_title_and_cta
    render_inline(Hero::CardHeroComponent.new(title: "Custom Title", cta_text: "Buy now", cta_url: "https://example.com"))

    assert_selector "h1", text: "Custom Title"
    assert_link "Buy now", href: "https://example.com"
  end
end
