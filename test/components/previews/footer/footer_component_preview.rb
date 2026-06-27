# frozen_string_literal: true

class Footer::FooterComponentPreview < ViewComponent::Preview
  def default
    render(Footer::FooterComponent.new)
  end
end
