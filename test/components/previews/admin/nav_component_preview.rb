# frozen_string_literal: true

# Preview at /rails/view_components/admin/nav_component
class Admin::NavComponentPreview < ViewComponent::Preview
  def default
    render(Admin::NavComponent.new(user_email: "admin@example.com"))
  end
end
