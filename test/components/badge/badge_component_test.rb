# frozen_string_literal: true

require "test_helper"

class Badge::BadgeComponentTest < ViewComponent::TestCase
  def test_renders_accent_pill_by_default
    render_inline(Badge::BadgeComponent.new(label: "Udemy Course"))

    assert_selector "span.badge-pill.badge-pill-accent", text: "Udemy Course"
  end

  def test_supports_variants
    render_inline(Badge::BadgeComponent.new(label: "New", variant: "dark"))

    assert_selector "span.badge-pill.badge-pill-dark", text: "New"
  end

  def test_falls_back_to_accent_for_an_unknown_variant
    render_inline(Badge::BadgeComponent.new(label: "X", variant: "bogus"))

    assert_selector "span.badge-pill-accent"
  end
end
