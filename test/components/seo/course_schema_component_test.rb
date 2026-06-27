# frozen_string_literal: true

require "test_helper"

class Seo::CourseSchemaComponentTest < ViewComponent::TestCase
  def test_renders_valid_course_json_ld
    node = render_inline(Seo::CourseSchemaComponent.new(url: "https://railsyeah.test/"))
    data = JSON.parse(node.css("script[type='application/ld+json']").text)

    assert_equal "https://schema.org", data["@context"]
    assert_equal "Course", data["@type"]
    assert_equal Site::COURSE, data["name"]
    assert_equal Site::TAGLINE, data["description"]
    assert_equal "https://railsyeah.test/", data["url"]
    assert_equal "Udemy", data.dig("provider", "name")
    assert_equal Site::INSTRUCTOR, data.dig("author", "name")
    assert_equal Site::INSTRUCTOR, data.dig("hasCourseInstance", "instructor", "name")
    assert_equal Site::RATING, data.dig("aggregateRating", "ratingValue")
    assert_equal Site::RATING_COUNT, data.dig("aggregateRating", "ratingCount")
  end
end
