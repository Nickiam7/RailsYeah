# frozen_string_literal: true

require "test_helper"

class Sections::CurriculumComponentTest < ViewComponent::TestCase
  def test_renders_expandable_sections_with_lectures
    section = CurriculumSection.new(title: "Introduction", duration: "13min")
    section.lectures.build(title: "Welcome", duration: "1:41", lecture_type: "video", preview: true)
    section.lectures.build(title: "Source Code", duration: "0:45", lecture_type: "article")

    render_inline(Sections::CurriculumComponent.new(sections: [ section ]))

    assert_selector "section#curriculum"
    assert_selector ".section-heading h2", text: "Course content"
    assert_selector ".accordion-item", count: 1
    assert_text "Introduction"
    assert_text "2 lectures · 13min"
    assert_selector ".curriculum-lecture", count: 2
    assert_text "Welcome"
    assert_selector ".curriculum-lecture-preview", text: "Preview", count: 1
  end

  def test_hidden_when_no_sections
    render_inline(Sections::CurriculumComponent.new(sections: []))

    assert_no_selector "section#curriculum"
  end
end
