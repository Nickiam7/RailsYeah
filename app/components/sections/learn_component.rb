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
      Card.new("app/models/entry.rb", <<~HTML.html_safe),
        <span class="tok-keyword">class</span> <span class="tok-constant">Entry</span> &lt; <span class="tok-constant">ApplicationRecord</span>
          <span class="tok-method">belongs_to</span> <span class="tok-symbol">:user</span>

          <span class="tok-method">validates</span> <span class="tok-symbol">:name</span>, <span class="tok-symbol">:username</span>, <span class="tok-symbol">:password</span>, presence: <span class="tok-keyword">true</span>
          <span class="tok-method">validate</span> <span class="tok-symbol">:url_must_be_valid</span>

          <span class="tok-method">encrypts</span> <span class="tok-symbol">:username</span>, deterministic: <span class="tok-keyword">true</span>
          <span class="tok-method">encrypts</span> <span class="tok-symbol">:password</span>

          <span class="tok-method">scope</span> <span class="tok-symbol">:search_name</span>, -&gt;(name) {
            <span class="tok-method">where</span>(<span class="tok-string">"entries.name ILIKE ?"</span>, <span class="tok-string">"%\#{name}%"</span>) <span class="tok-keyword">if</span> name.<span class="tok-method">present?</span>
          }

          <span class="tok-keyword">def</span> <span class="tok-keyword">self</span>.<span class="tok-method">search</span>(name)
            <span class="tok-method">search_name</span>(name).<span class="tok-method">order</span>(<span class="tok-symbol">:name</span>)
          <span class="tok-keyword">end</span>

          <span class="tok-keyword">private</span>

          <span class="tok-keyword">def</span> <span class="tok-method">url_must_be_valid</span>
            <span class="tok-keyword">unless</span> url.<span class="tok-method">include?</span>(<span class="tok-string">'http'</span> || <span class="tok-string">'https'</span>)
              <span class="tok-method">errors</span>.<span class="tok-method">add</span>(<span class="tok-symbol">:url</span>, <span class="tok-string">'must be valid'</span>)
            <span class="tok-keyword">end</span>
          <span class="tok-keyword">end</span>
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
