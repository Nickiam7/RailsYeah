# frozen_string_literal: true

require "test_helper"

class LandingPageContentTest < ActionDispatch::IntegrationTest
  test "the landing page renders content from the editable models" do
    get root_path
    assert_response :success

    assert_select "h1", text: "Test Course Title"           # HeroContent
    assert_match "Learn the first thing", response.body      # LearningObjective
    assert_match "Test Introduction Section", response.body  # CurriculumSection
    assert_match "This course was fantastic", response.body  # Testimonial (published)
    assert_match "Is this a test question?", response.body   # FaqItem (published)
    assert_match "Test Instructor", response.body            # Instructor
  end

  test "unpublished testimonials and FAQ items are hidden" do
    get root_path

    assert_no_match(/This testimonial is unpublished/, response.body)
    assert_no_match(/Hidden question/, response.body)
  end
end
