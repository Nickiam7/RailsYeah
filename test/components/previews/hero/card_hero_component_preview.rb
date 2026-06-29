# frozen_string_literal: true

# Preview at /rails/view_components/hero/card_hero_component
class Hero::CardHeroComponentPreview < ViewComponent::Preview
  def default
    render(Hero::CardHeroComponent.new)
  end
end
