# frozen_string_literal: true

# A Tiptap-backed rich-text field for admin content forms. Renders a toolbar, the
# editor surface, and the underlying <textarea> that actually submits the HTML. The
# rich_text Stimulus controller progressively enhances the textarea; with no JS the
# textarea is a plain (still usable) fallback. (#2947)
class Admin::RichTextFieldComponent < ApplicationComponent
  Button = Data.define(:label, :command, :level)

  def initialize(form:, attribute:, label: nil)
    @form = form
    @attribute = attribute
    @label = label
  end

  private

  attr_reader :form, :attribute, :label

  def label_text
    label || attribute.to_s.humanize
  end

  def buttons
    [
      Button.new("Bold", "bold", nil),
      Button.new("Italic", "italic", nil),
      Button.new("H2", "heading", 2),
      Button.new("H3", "heading", 3),
      Button.new("List", "bulletList", nil),
      Button.new("1. List", "orderedList", nil),
      Button.new("Quote", "blockquote", nil),
      Button.new("Link", "link", nil)
    ]
  end
end
