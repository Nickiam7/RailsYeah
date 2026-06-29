# frozen_string_literal: true

# A non-symmetrical "cloud" of instructor reviews (sidecar): two staggered columns
# of small cards (avatar, name, star rating, title, body) over a soft blob.
# Placeholder reviews for now.
class Instructor::TestimonialsComponent < ApplicationComponent
  Review = Data.define(:name, :rating, :title, :body)

  PLACEHOLDERS = [
    Review.new("Priya S.", 5, "Finally, Rails that clicks.",
               "Nick's explanations are so clear. I'd bounced off other courses, but the way he builds " \
               "things up step by step made it all make sense."),
    Review.new("Elena K.", 5, "Worth every minute.",
               "Asked a question in the Q&A and got a thorough answer the same day."),
    Review.new("Sarah N.", 5, "Best Rails teacher out there.",
               "I went from copy-pasting tutorials to actually understanding what I'm writing. The Hotwire " \
               "sections are gold."),
    Review.new("Monica T.", 5, "Exactly what I needed.",
               "Everything is practical and real-world. I'm already using patterns from the course at work, " \
               "and I've recommended it to my whole team."),
    Review.new("Dan T.", 5, "Love it.",
               "Clear, practical, and genuinely fun to learn from."),
    Review.new("John D.", 4, "Great, with room to grow.",
               "Solid all around. A couple of sections I wanted to go even deeper on, but I shipped a real " \
               "app by the end and learned a ton.")
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
