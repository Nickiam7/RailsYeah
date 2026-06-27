# frozen_string_literal: true

# Preview at /rails/view_components/hero/hero_component
class Hero::HeroComponentPreview < ViewComponent::Preview
  def default
    render(Hero::HeroComponent.new)
  end
end
