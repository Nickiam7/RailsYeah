# frozen_string_literal: true

# Preview at /rails/view_components/navbar/navbar_component
class Navbar::NavbarComponentPreview < ViewComponent::Preview
  def default
    render(Navbar::NavbarComponent.new)
  end
end
