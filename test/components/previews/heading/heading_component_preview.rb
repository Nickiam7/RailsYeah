# frozen_string_literal: true

# Preview at /rails/view_components/heading/heading_component
class Heading::HeadingComponentPreview < ViewComponent::Preview
  def default
    render(Heading::HeadingComponent.new(title: "Build a Rails 8 Password Manager"))
  end

  def with_subtitle
    render(Heading::HeadingComponent.new(
      title: "Build a Rails 8 Password Manager",
      subtitle: "Hotwire, a secure JSON API, and a Chrome extension — from scratch"
    ))
  end

  def centered_section_heading
    render(Heading::HeadingComponent.new(
      title: "What you'll learn",
      level: 2,
      align: "center"
    ))
  end
end
