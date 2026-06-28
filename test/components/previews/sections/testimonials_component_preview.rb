# frozen_string_literal: true

# Preview at /rails/view_components/sections/testimonials_component
class Sections::TestimonialsComponentPreview < ViewComponent::Preview
  def default
    testimonials = [
      Testimonial.new(name: "Alex P.", role: "Backend Developer", rating: 5,
                      quote: "The clearest Rails course I've taken — the Hotwire sections finally made it click."),
      Testimonial.new(name: "Priya S.", role: "Full-stack Engineer", rating: 5,
                      quote: "Loved building the JSON API and the Chrome extension end to end."),
      Testimonial.new(name: "Marcus L.", role: "Rails Developer", rating: 4,
                      quote: "Great pacing and real-world patterns I now use at work.")
    ]

    render(Sections::TestimonialsComponent.new(testimonials: testimonials))
  end
end
