# frozen_string_literal: true

# Reviews / testimonials section (sidecar). Renders published testimonials.
class Sections::TestimonialsComponent < ApplicationComponent
  def initialize(testimonials:)
    @testimonials = testimonials
  end

  def render?
    testimonials.any?
  end

  private

  attr_reader :testimonials

  def stars(rating)
    return if rating.blank?

    "★" * rating
  end
end
