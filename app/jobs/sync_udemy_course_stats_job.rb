class SyncUdemyCourseStatsJob < ApplicationJob
  queue_as :default

  # Fetch live course stats and upsert the singleton CourseStat. On any client
  # error, keep the last good record (the views fall back to Site:: if none exists).
  def perform(client: Udemy::Client.new)
    stats = client.course_stats

    record = CourseStat.current || CourseStat.new
    record.update!(
      rating: stats[:rating],
      reviews_count: stats[:reviews_count],
      synced_at: Time.current
    )
    Rails.logger.info("[SyncUdemyCourseStatsJob] synced rating=#{record.rating} reviews=#{record.reviews_count}")
  rescue Udemy::Client::Error => e
    Rails.logger.warn("[SyncUdemyCourseStatsJob] skipped, keeping last values: #{e.message}")
  end
end
