# frozen_string_literal: true

# Preview at /rails/view_components/code/code_card_component
class Code::CodeCardComponentPreview < ViewComponent::Preview
  # Hand-marked syntax coloring via .tok-* spans (no JS highlighter).
  def highlighted
    render(Code::CodeCardComponent.new(filename: "app/models/article.rb")) do
      <<~HTML.html_safe
        <span class="tok-keyword">class</span> <span class="tok-constant">Article</span> &lt; <span class="tok-constant">ApplicationRecord</span>
          <span class="tok-method">has_many</span> <span class="tok-symbol">:comments</span>, dependent: <span class="tok-symbol">:destroy</span>
          <span class="tok-method">validates</span> <span class="tok-symbol">:title</span>, presence: <span class="tok-keyword">true</span>
        <span class="tok-keyword">end</span>
      HTML
    end
  end

  # Plain code (HTML-escaped) on the themed dark card.
  def plain
    render(Code::CodeCardComponent.new(
      filename: "config/routes.rb",
      code: "Rails.application.routes.draw do\n  resources :articles\nend"
    ))
  end
end
