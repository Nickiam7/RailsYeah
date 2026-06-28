require "test_helper"

class SyncUdemyCourseStatsJobTest < ActiveJob::TestCase
  # Stand-in for Udemy::Client that returns canned stats or raises.
  class FakeClient
    def initialize(stats: nil, error: nil)
      @stats = stats
      @error = error
    end

    def course_stats
      raise @error if @error

      @stats
    end
  end

  test "creates a CourseStat from the client" do
    client = FakeClient.new(stats: { rating: 4.62, reviews_count: 82, title: "C" })

    assert_difference -> { CourseStat.count }, 1 do
      SyncUdemyCourseStatsJob.perform_now(client: client)
    end

    assert_equal 82, CourseStat.current.reviews_count
  end

  test "updates the existing record rather than creating a new one" do
    CourseStat.create!(rating: 4.0, reviews_count: 10, synced_at: 1.day.ago)
    client = FakeClient.new(stats: { rating: 4.62, reviews_count: 82, title: "C" })

    assert_no_difference -> { CourseStat.count } do
      SyncUdemyCourseStatsJob.perform_now(client: client)
    end

    assert_equal 82, CourseStat.current.reviews_count
  end

  test "keeps the last good record when the client errors" do
    CourseStat.create!(rating: 4.5, reviews_count: 50, synced_at: 1.day.ago)
    client = FakeClient.new(error: Udemy::Client::Error.new("boom"))

    assert_nothing_raised { SyncUdemyCourseStatsJob.perform_now(client: client) }

    assert_equal 50, CourseStat.current.reviews_count
  end
end
