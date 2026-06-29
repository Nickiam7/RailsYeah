# frozen_string_literal: true

require "test_helper"

class Sections::LearnComponentTest < ViewComponent::TestCase
  def test_renders_section_heading_and_objectives_with_checks
    objectives = [
      LearningObjective.new(description: "Build a secure JSON API"),
      LearningObjective.new(description: "Ship a Chrome extension")
    ]

    render_inline(Sections::LearnComponent.new(objectives: objectives))

    assert_selector "section#learn"
    assert_selector ".section-heading h2", text: "What you'll learn"
    # One badge per objective, plus the trailing "And much more" link.
    assert_selector ".check-badge", count: 3
    assert_text "Build a secure JSON API"
    assert_text "Ship a Chrome extension"
    assert_link "And much more", href: Site::UDEMY_URL
  end

  def test_hidden_when_no_objectives
    render_inline(Sections::LearnComponent.new(objectives: []))

    assert_no_selector "section#learn"
  end
end
