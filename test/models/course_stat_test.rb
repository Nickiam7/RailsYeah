require "test_helper"

class CourseStatTest < ActiveSupport::TestCase
  test "falls back to the Site defaults when no record exists" do
    assert_nil CourseStat.current
    assert_equal format("%.1f", Site::RATING.to_f), CourseStat.rating_display
    assert_equal Site::RATING_COUNT, CourseStat.reviews_count
  end

  test "rating_display formats the synced rating to one decimal" do
    CourseStat.create!(rating: 4.6174765, reviews_count: 82, synced_at: Time.current)

    assert_equal "4.6", CourseStat.rating_display
    assert_equal 82, CourseStat.reviews_count
  end
end
