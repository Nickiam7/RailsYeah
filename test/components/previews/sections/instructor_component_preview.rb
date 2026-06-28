# frozen_string_literal: true

# Preview at /rails/view_components/sections/instructor_component
class Sections::InstructorComponentPreview < ViewComponent::Preview
  def default
    instructor = Instructor.new(
      name: "Nick McNeany",
      headline: "Ruby on Rails instructor",
      bio: "<p>Nick builds full-stack Ruby on Rails applications and teaches the modern, " \
           "Hotwire-first way to ship them — from secure JSON APIs to browser extensions.</p>"
    )

    render(Sections::InstructorComponent.new(instructor: instructor))
  end
end
