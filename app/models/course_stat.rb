class CourseStat < ApplicationRecord
  # Singleton: the landing page reads the single synced stats record.
  def self.current
    first
  end

  # Rating formatted to one decimal (e.g. "4.6"), falling back to the Site default.
  def self.rating_display
    value = current&.rating || Site::RATING.to_f
    format("%.1f", value)
  end

  # Review count, falling back to the Site default.
  def self.reviews_count
    current&.reviews_count || Site::RATING_COUNT
  end
end
