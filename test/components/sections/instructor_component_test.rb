# frozen_string_literal: true

require "test_helper"

class Sections::InstructorComponentTest < ViewComponent::TestCase
  def test_renders_heading_name_headline_and_bio
    instructor = Instructor.new(
      name: "Nick McNeany",
      headline: "Ruby on Rails instructor",
      bio: "<p>Builds full-stack Rails apps.</p>"
    )

    render_inline(Sections::InstructorComponent.new(instructor: instructor))

    assert_selector "section#instructor"
    assert_selector ".section-heading h2", text: "Meet your instructor"
    assert_text "Nick McNeany"
    assert_text "Ruby on Rails instructor"
    assert_text "Builds full-stack Rails apps."
    # No avatar attached -> placeholder initial shown.
    assert_selector ".instructor-avatar-placeholder", text: "N"
  end

  def test_hidden_when_no_instructor
    render_inline(Sections::InstructorComponent.new(instructor: nil))

    assert_no_selector "section#instructor"
  end
end
