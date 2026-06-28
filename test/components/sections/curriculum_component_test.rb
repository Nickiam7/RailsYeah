# frozen_string_literal: true

require "test_helper"

class Sections::CurriculumComponentTest < ViewComponent::TestCase
  def test_renders_section_heading_and_sections_with_meta
    sections = [
      CurriculumSection.new(title: "Introduction", lectures_count: 4, duration: "13min"),
      CurriculumSection.new(title: "Authentication", lectures_count: 6, duration: "1hr 6min")
    ]

    render_inline(Sections::CurriculumComponent.new(sections: sections))

    assert_selector "section#curriculum"
    assert_selector ".section-heading h2", text: "Course content"
    assert_selector ".curriculum-section", count: 2
    assert_text "Introduction"
    assert_text "4 lectures · 13min"
  end

  def test_hidden_when_no_sections
    render_inline(Sections::CurriculumComponent.new(sections: []))

    assert_no_selector "section#curriculum"
  end
end
