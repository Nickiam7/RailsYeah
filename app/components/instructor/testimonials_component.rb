# frozen_string_literal: true

# A non-symmetrical "cloud" of instructor reviews (sidecar): two staggered columns
# of small cards (avatar, name, star rating, title, body) over a soft blob.
# Placeholder reviews for now.
class Instructor::TestimonialsComponent < ApplicationComponent
  Review = Data.define(:name, :rating, :title, :body)

  PLACEHOLDERS = [
    Review.new("Aaron", 5, "Amazing course and instructor.",
               ""),
    Review.new("Oscar M.", 5, "Great teaching, awesome content.",
               ""),
    Review.new("André", 5, "This was a really good course to get into Rails and to also understand how Hotwire works.",
               ""),
    Review.new("David Oliveira", 5, "The explanations by the teacher are clear and direct, exactly what I'm looking for.",
               "")
  ].freeze

  def initialize(testimonials: PLACEHOLDERS)
    @testimonials = testimonials
  end

  def render?
    testimonials.any?
  end

  private

  attr_reader :testimonials

  # Split into two staggered columns (even indexes left, odd right).
  def columns
    testimonials.partition.with_index { |_, i| i.even? }
  end
end
