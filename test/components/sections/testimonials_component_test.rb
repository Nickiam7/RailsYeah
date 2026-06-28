# frozen_string_literal: true

require "test_helper"

class Sections::TestimonialsComponentTest < ViewComponent::TestCase
  def test_renders_heading_and_testimonial_cards
    testimonials = [
      Testimonial.new(name: "Alex P.", role: "Backend Developer", rating: 5, quote: "Great course"),
      Testimonial.new(name: "Priya S.", rating: 4, quote: "Loved it")
    ]

    render_inline(Sections::TestimonialsComponent.new(testimonials: testimonials))

    assert_selector "section#reviews"
    assert_selector ".section-heading h2", text: "What students say"
    assert_selector ".testimonial-card", count: 2
    assert_selector ".star-rating", minimum: 1
    assert_text "Alex P."
    assert_text "Backend Developer"
  end

  def test_hidden_when_no_testimonials
    render_inline(Sections::TestimonialsComponent.new(testimonials: []))

    assert_no_selector "section#reviews"
  end
end
