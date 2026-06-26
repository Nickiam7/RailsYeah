# frozen_string_literal: true

# Sample interactive component (Story #2932): a Bootstrap-styled button wired to
# the `counter` Stimulus controller. Demonstrates the Bootstrap + Stimulus +
# ViewComponent stack the app standardizes on going forward.
class Counter::CounterComponent < ApplicationComponent
  def initialize(label: "Count")
    @label = label
  end

  private

  attr_reader :label
end
