# frozen_string_literal: true

# Preview at /rails/view_components/seo/meta_component (renders raw head tags)
class Seo::MetaComponentPreview < ViewComponent::Preview
  def default
    render(Seo::MetaComponent.new(url: "https://example.com/"))
  end
end
