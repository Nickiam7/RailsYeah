# frozen_string_literal: true

require "test_helper"

class Admin::RichTextFieldComponentTest < ViewComponent::TestCase
  def test_renders_editor_with_toolbar_and_seeds_the_textarea
    form = ActionView::Helpers::FormBuilder.new(
      :instructor, Instructor.new(bio: "<p>Hello there</p>"), vc_test_controller.view_context, {}
    )

    render_inline(Admin::RichTextFieldComponent.new(form: form, attribute: :bio))

    # The Stimulus controller + its targets are what mount Tiptap on the page.
    assert_selector "[data-controller='rich-text']"
    assert_selector "[data-rich-text-target='editor']"
    assert_selector "textarea[data-rich-text-target='input']", visible: :all
    # Toolbar commands are wired.
    assert_selector "button[data-action='rich-text#command'][data-command='bold']"
    assert_selector "button[data-command='heading'][data-level='2']"
    # Existing content is seeded into the textarea the form submits.
    assert_includes rendered_content, "Hello there"
  end
end
