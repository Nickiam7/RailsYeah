# frozen_string_literal: true

require "application_system_test_case"

# Verifies the Hotwire stack is wired up end-to-end in a real browser:
# Stimulus controllers load and fire, and Turbo Drive is enabled (Story #2932).
class HotwireTest < ApplicationSystemTestCase
  test "the sample Stimulus controller connects and responds to a click action" do
    visit root_path

    # connect() runs on load and replaces the no-JS fallback text.
    assert_text "Stimulus connected"
    assert_no_text "Stimulus not connected"

    # The increment action fires on click and updates the output.
    click_button "Stimulus check (click me)"
    assert_text "Clicked 1 time"

    click_button "Stimulus check (click me)"
    assert_text "Clicked 2 times"
  end

  test "Turbo is loaded and Turbo Drive is available" do
    visit root_path

    assert_equal "object", evaluate_script("typeof window.Turbo")
    assert_equal "function", evaluate_script("typeof window.Turbo.visit")
  end
end
