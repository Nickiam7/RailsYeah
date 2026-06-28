# frozen_string_literal: true

require "test_helper"

class Heading::SectionHeadingComponentTest < ViewComponent::TestCase
  def test_renders_eyebrow_bold_red_title_and_copy
    render_inline(Heading::SectionHeadingComponent.new(
      eyebrow: "What you'll learn", title: "Everything you need.", copy: "Supporting copy."
    ))

    assert_selector "p.eyebrow", text: "What you'll learn"
    assert_selector "h2.heading-display.text-accent", text: "Everything you need."
    assert_selector "p.lead-copy", text: "Supporting copy."
  end

  def test_omits_optional_eyebrow_and_copy
    render_inline(Heading::SectionHeadingComponent.new(title: "Frequently asked questions"))

    assert_selector "h2.heading-display", text: "Frequently asked questions"
    assert_no_selector "p.eyebrow"
    assert_no_selector "p.lead-copy"
  end

  def test_supports_level_alignment_and_neutral_title
    render_inline(Heading::SectionHeadingComponent.new(
      title: "Your instructor", level: 3, align: "center", accent: false
    ))

    assert_selector "div.section-heading.text-center"
    assert_selector "h3.heading-display", text: "Your instructor"
    assert_no_selector ".text-accent"
  end
end
