# frozen_string_literal: true

require "test_helper"

class Heading::HeadingComponentTest < ViewComponent::TestCase
  def test_renders_the_title_in_an_h1_by_default
    render_inline(Heading::HeadingComponent.new(title: "Hello world"))

    assert_selector("div.text-start h1.fw-bold", text: "Hello world")
    assert_no_selector("p.lead")
  end

  def test_renders_optional_subtitle_and_honors_level_and_alignment
    render_inline(
      Heading::HeadingComponent.new(title: "Section", subtitle: "Details", level: 2, align: "center")
    )

    assert_selector("div.text-center h2.fw-bold", text: "Section")
    assert_selector("p.lead.text-body-secondary", text: "Details")
  end
end
