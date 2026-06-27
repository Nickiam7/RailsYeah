# frozen_string_literal: true

require "application_system_test_case"

# Verifies the Hotwire stack is loaded app-wide in a real browser: Turbo Drive and
# Stimulus are both available on the rendered landing page (Story #2932). The
# Stimulus controllers themselves are covered by component tests + previews.
class HotwireTest < ApplicationSystemTestCase
  test "Turbo and Stimulus are loaded app-wide" do
    visit root_path

    assert_equal "object", evaluate_script("typeof window.Turbo")
    assert_equal "function", evaluate_script("typeof window.Turbo.visit")
    assert_equal "object", evaluate_script("typeof window.Stimulus")
  end
end
