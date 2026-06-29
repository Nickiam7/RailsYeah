# frozen_string_literal: true

# "What you'll learn" section (sidecar). Objectives stacked in one column, with a
# stack of code-card visuals in the other. Objectives come from the model; the code
# cards are placeholder snippets for now.
class Sections::LearnComponent < ApplicationComponent
  Card = Data.define(:filename, :code)

  def initialize(objectives:)
    @objectives = objectives
  end

  def render?
    objectives.any?
  end

  private

  attr_reader :objectives

  # Placeholder code-card snippets (course-flavored). Static, hand-marked markup.
  def code_cards
    [
      Card.new("app/models/user.rb", <<~HTML.html_safe),
        <span class="tok-keyword">class</span> <span class="tok-constant">User</span> &lt; <span class="tok-constant">ApplicationRecord</span>
          <span class="tok-method">has_secure_password</span>
          <span class="tok-method">has_many</span> <span class="tok-symbol">:vaults</span>, dependent: <span class="tok-symbol">:destroy</span>
        <span class="tok-keyword">end</span>
      HTML
      Card.new("app/controllers/api/sessions_controller.rb", <<~HTML.html_safe),
        <span class="tok-keyword">class</span> <span class="tok-constant">Api::SessionsController</span> &lt; <span class="tok-constant">ApiController</span>
          <span class="tok-keyword">def</span> <span class="tok-method">create</span>
            user = <span class="tok-constant">User</span>.<span class="tok-method">authenticate_by</span>(login_params)
            <span class="tok-method">render</span> json: { token: <span class="tok-method">issue_jwt</span>(user) }
          <span class="tok-keyword">end</span>
        <span class="tok-keyword">end</span>
      HTML
      Card.new("app/javascript/controllers/autofill_controller.js", <<~HTML.html_safe)
        <span class="tok-keyword">import</span> { <span class="tok-constant">Controller</span> } <span class="tok-keyword">from</span> <span class="tok-string">"@hotwired/stimulus"</span>

        <span class="tok-keyword">export default class extends</span> <span class="tok-constant">Controller</span> {
          <span class="tok-method">fill</span>({ params }) {
            <span class="tok-keyword">this</span>.passwordTarget.value = params.secret
          }
        }
      HTML
    ]
  end
end
