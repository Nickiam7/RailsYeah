# frozen_string_literal: true

require "test_helper"

class Counter::CounterComponentTest < ViewComponent::TestCase
  def test_renders_button_and_output_wired_to_the_counter_stimulus_controller
    render_inline(Counter::CounterComponent.new(label: "Count"))

    assert_selector("div[data-controller='counter']")
    assert_selector("button[data-action='counter#increment']", text: "Count")
    assert_selector("[data-counter-target='output']", text: "Stimulus not connected")
  end
end
