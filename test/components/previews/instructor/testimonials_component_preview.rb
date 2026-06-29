# frozen_string_literal: true

# Preview at /rails/view_components/instructor/testimonials_component
class Instructor::TestimonialsComponentPreview < ViewComponent::Preview
  def default
    render(Instructor::TestimonialsComponent.new)
  end
end
