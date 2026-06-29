# frozen_string_literal: true

# A non-symmetrical "cloud" of short testimonials about the instructor (sidecar).
# Rendered as a masonry-style grid of small quote cards. Placeholder quotes for now.
class Instructor::TestimonialsComponent < ApplicationComponent
  Quote = Data.define(:quote, :name)

  PLACEHOLDERS = [
    Quote.new("Nick explains complex topics in a way that finally made them click for me.", "Sarah K."),
    Quote.new("The clearest Rails teaching I've found — hands down.", "Devon R."),
    Quote.new("I went from stuck to shipping real features at work.", "Marco T."),
    Quote.new("Every lesson is packed with practical, real-world insight.", "Aisha N."),
    Quote.new("Patient, thorough, and genuinely fun to learn from.", "James P.")
  ].freeze

  def initialize(testimonials: PLACEHOLDERS)
    @testimonials = testimonials
  end

  def render?
    testimonials.any?
  end

  private

  attr_reader :testimonials
end
