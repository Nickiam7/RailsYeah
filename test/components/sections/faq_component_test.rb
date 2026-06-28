# frozen_string_literal: true

require "test_helper"

class Sections::FaqComponentTest < ViewComponent::TestCase
  def test_renders_heading_and_accordion_items
    items = [
      FaqItem.new(question: "Do I need prior Rails experience?", answer: "<p>Some Ruby basics help.</p>"),
      FaqItem.new(question: "Does it cover Hotwire?", answer: "<p>Yes, throughout.</p>")
    ]

    render_inline(Sections::FaqComponent.new(items: items))

    assert_selector "section#faq"
    assert_selector ".section-heading h2", text: "Frequently asked questions"
    assert_selector ".faq-accordion .accordion-item", count: 2
    assert_selector "button.accordion-button", text: "Do I need prior Rails experience?"
    assert_text "Some Ruby basics help."
  end

  def test_hidden_when_no_items
    render_inline(Sections::FaqComponent.new(items: []))

    assert_no_selector "section#faq"
  end
end
