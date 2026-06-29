# frozen_string_literal: true

# Preview at /rails/view_components/code/editor_component
class Code::EditorComponentPreview < ViewComponent::Preview
  Snippet = Data.define(:filename, :code)

  def default
    files = [
      Snippet.new("app/models/entry.rb", <<~HTML.html_safe),
        <span class="tok-keyword">class</span> <span class="tok-constant">Entry</span> &lt; <span class="tok-constant">ApplicationRecord</span>
          <span class="tok-method">belongs_to</span> <span class="tok-symbol">:user</span>
          <span class="tok-method">encrypts</span> <span class="tok-symbol">:password</span>
        <span class="tok-keyword">end</span>
      HTML
      Snippet.new("app/javascript/controllers/autofill_controller.js", <<~HTML.html_safe)
        <span class="tok-keyword">import</span> { <span class="tok-constant">Controller</span> } <span class="tok-keyword">from</span> <span class="tok-string">"@hotwired/stimulus"</span>

        <span class="tok-keyword">export default class extends</span> <span class="tok-constant">Controller</span> {}
      HTML
    ]

    render(Code::EditorComponent.new(files: files))
  end
end
