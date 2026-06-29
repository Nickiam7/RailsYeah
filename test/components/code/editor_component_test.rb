# frozen_string_literal: true

require "test_helper"

class Code::EditorComponentTest < ViewComponent::TestCase
  Snippet = Data.define(:filename, :code)

  def test_renders_tabs_and_panes_with_the_first_active
    files = [
      Snippet.new("app/models/entry.rb", "<span>model</span>".html_safe),
      Snippet.new("app/javascript/controllers/autofill_controller.js", "<span>js</span>".html_safe)
    ]

    render_inline(Code::EditorComponent.new(files: files))

    assert_selector ".code-editor"
    assert_selector ".code-editor-tab", count: 2
    assert_selector ".code-editor-tab.active", text: "entry.rb"
    assert_selector ".code-editor-tab", text: "autofill_controller.js"
    assert_selector ".code-editor-dot--rb"
    assert_selector ".code-editor-dot--js"
    assert_selector ".tab-pane", count: 2
    assert_selector ".tab-pane.active code", text: "model"
  end
end
