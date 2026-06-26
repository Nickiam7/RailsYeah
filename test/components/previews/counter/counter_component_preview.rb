# frozen_string_literal: true

# Preview at /rails/view_components/counter/counter_component
# (The Stimulus behavior runs in the live preview, not in render_inline tests.)
class Counter::CounterComponentPreview < ViewComponent::Preview
  def default
    render(Counter::CounterComponent.new)
  end

  def custom_label
    render(Counter::CounterComponent.new(label: "Click me"))
  end
end
