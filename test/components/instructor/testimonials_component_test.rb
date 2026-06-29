# frozen_string_literal: true

require "test_helper"

class Instructor::TestimonialsComponentTest < ViewComponent::TestCase
  def test_renders_a_card_per_review
    reviews = [
      Instructor::TestimonialsComponent::Review.new("Sam", 5, "Great teacher.", "Learned a ton."),
      Instructor::TestimonialsComponent::Review.new("Riley", 4, "Solid course.", "Would recommend.")
    ]

    render_inline(Instructor::TestimonialsComponent.new(testimonials: reviews))

    assert_selector ".instructor-cloud .instructor-cloud-card", count: 2
    assert_text "Great teacher."
    assert_text "Sam"
  end

  def test_hidden_when_empty
    render_inline(Instructor::TestimonialsComponent.new(testimonials: []))

    assert_no_selector ".instructor-cloud"
  end
end
