# frozen_string_literal: true

# Preview at /rails/view_components/sections/faq_component
class Sections::FaqComponentPreview < ViewComponent::Preview
  def default
    items = [
      FaqItem.new(question: "Do I need prior Rails experience?",
                  answer: "<p>Some Ruby basics help, but the course builds up from the fundamentals.</p>"),
      FaqItem.new(question: "Does the course cover Hotwire?",
                  answer: "<p>Yes — Turbo and Stimulus are used throughout to build an SPA-like experience.</p>"),
      FaqItem.new(question: "Is there a Chrome extension section?",
                  answer: "<p>Absolutely. You'll build a Chrome extension that consumes the JSON API.</p>")
    ]

    render(Sections::FaqComponent.new(items: items))
  end
end
