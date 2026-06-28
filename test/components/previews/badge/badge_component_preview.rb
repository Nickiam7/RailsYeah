# frozen_string_literal: true

# Preview at /rails/view_components/badge/badge_component
class Badge::BadgeComponentPreview < ViewComponent::Preview
  def accent
    render(Badge::BadgeComponent.new(label: "Udemy Course"))
  end

  def light
    render(Badge::BadgeComponent.new(label: "Bestseller", variant: "light"))
  end

  def dark
    render(Badge::BadgeComponent.new(label: "New", variant: "dark"))
  end
end
