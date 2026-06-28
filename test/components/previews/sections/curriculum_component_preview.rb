# frozen_string_literal: true

# Preview at /rails/view_components/sections/curriculum_component
class Sections::CurriculumComponentPreview < ViewComponent::Preview
  def default
    sections = [
      CurriculumSection.new(title: "Introduction", lectures_count: 4, duration: "13min"),
      CurriculumSection.new(title: "Creating our Ruby on Rails Application", lectures_count: 3, duration: "20min"),
      CurriculumSection.new(title: "Authentication", lectures_count: 6, duration: "1hr 6min"),
      CurriculumSection.new(title: "Building the JSON API", lectures_count: 8, duration: "1hr 42min")
    ]

    render(Sections::CurriculumComponent.new(sections: sections))
  end
end
