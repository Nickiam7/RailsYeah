# frozen_string_literal: true

# "What you'll learn" section (sidecar). Objectives stacked in one column, with a
# tabbed code editor in the other. Objectives come from the model; the editor's
# files are placeholder, course-flavored snippets for now.
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

  # Placeholder code snippets (course-flavored). Static, hand-marked markup; chomped
  # so each file's line count is exact (no trailing blank line).
  def code_cards
    [
      Card.new("app/models/entry.rb", <<~HTML.chomp.html_safe),
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
      Card.new("app/controllers/api/v1/auth_controller.rb", <<~HTML.chomp.html_safe),
        <span class="tok-keyword">class</span> <span class="tok-constant">Api::V1::AuthController</span> &lt; <span class="tok-constant">Api::V1::ApiBaseController</span>
          <span class="tok-method">skip_before_action</span> <span class="tok-symbol">:authenticate_token</span>

          <span class="tok-keyword">def</span> <span class="tok-method">create</span>
            user = <span class="tok-constant">User</span>.<span class="tok-method">find_by</span>(email: params[<span class="tok-symbol">:email</span>])
            <span class="tok-keyword">if</span> user&amp;.<span class="tok-method">valid_password?</span>(params[<span class="tok-symbol">:password</span>])
              <span class="tok-method">render</span> json: {token: <span class="tok-constant">JsonWebToken</span>.<span class="tok-method">encode</span>(sub: user.id)}, status: <span class="tok-symbol">:ok</span>
            <span class="tok-keyword">else</span>
              <span class="tok-method">render</span> json: {errors: [<span class="tok-string">"Invalid email or password"</span>]}, status: <span class="tok-symbol">:unauthorized</span>
            <span class="tok-keyword">end</span>
          <span class="tok-keyword">end</span>
        <span class="tok-keyword">end</span>
      HTML
      Card.new("app/javascript/controllers/clipboard_controller.js", <<~HTML.chomp.html_safe)
        <span class="tok-keyword">import</span> { <span class="tok-constant">Controller</span> } <span class="tok-keyword">from</span> <span class="tok-string">"@hotwired/stimulus"</span>

        <span class="tok-keyword">import</span> { checkIcon, clipboardIcon } <span class="tok-keyword">from</span> <span class="tok-string">"../utils/icons"</span>

        <span class="tok-keyword">class</span> <span class="tok-constant">ClipboardController</span> <span class="tok-keyword">extends</span> <span class="tok-constant">Controller</span> {
          <span class="tok-keyword">async</span> <span class="tok-method">copy</span>({ params: { content } }) {
            <span class="tok-keyword">try</span> {
              <span class="tok-keyword">await</span> navigator.clipboard.<span class="tok-method">writeText</span>(content)
              <span class="tok-keyword">this</span>.element.innerHTML = checkIcon
              <span class="tok-method">setTimeout</span>(() =&gt; {
                <span class="tok-keyword">this</span>.element.innerHTML = clipboardIcon
              }, 1000)
            } <span class="tok-keyword">catch</span>(e) {
              console.<span class="tok-method">error</span>(<span class="tok-string">'Failed to copy.'</span>)
            }
          }
        }

        <span class="tok-keyword">export default</span> <span class="tok-constant">ClipboardController</span>
      HTML
    ]
  end
end
