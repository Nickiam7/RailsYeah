# frozen_string_literal: true

# Preview at /rails/view_components/heading/section_heading_component
class Heading::SectionHeadingComponentPreview < ViewComponent::Preview
  def default
    render(Heading::SectionHeadingComponent.new(
      eyebrow: "What you'll learn",
      title: "Everything you need.",
      copy: "Build a modern full-stack Rails app — from a secure JSON API to a Chrome extension."
    ))
  end

  def centered
    render(Heading::SectionHeadingComponent.new(
      eyebrow: "Curriculum",
      title: "From zero to shipped.",
      copy: "A guided path through the entire build.",
      align: "center"
    ))
  end

  def title_only
    render(Heading::SectionHeadingComponent.new(title: "Frequently asked questions"))
  end

  def neutral_title
    render(Heading::SectionHeadingComponent.new(
      eyebrow: "Meet your guide",
      title: "Your instructor",
      accent: false
    ))
  end
end
