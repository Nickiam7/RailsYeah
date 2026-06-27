# frozen_string_literal: true

require "test_helper"

class CourseSchemaTest < ActionDispatch::IntegrationTest
  test "landing page embeds schema.org Course JSON-LD" do
    get root_path
    assert_response :success

    scripts = css_select("script[type='application/ld+json']")
    assert_equal 1, scripts.size

    data = JSON.parse(scripts.first.text)
    assert_equal "Course", data["@type"]
    assert_equal Site::COURSE, data["name"]
    assert_equal "Udemy", data.dig("provider", "name")
    assert_equal Site::INSTRUCTOR, data.dig("author", "name")
  end
end
