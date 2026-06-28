# frozen_string_literal: true

# Preview at /rails/view_components/navbar/navbar_component
class Navbar::NavbarComponentPreview < ViewComponent::Preview
  def default
    render(Navbar::NavbarComponent.new)
  end

  def signed_in
    render(Navbar::NavbarComponent.new(signed_in: true))
  end
end
