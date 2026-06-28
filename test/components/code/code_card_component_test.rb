# frozen_string_literal: true

require "test_helper"

class Code::CodeCardComponentTest < ViewComponent::TestCase
  def test_renders_filename_bar_and_escaped_code_body
    render_inline(Code::CodeCardComponent.new(filename: "app/models/article.rb", code: "class Article; end"))

    assert_selector "div.code-card"
    assert_selector ".code-card-filename", text: "app/models/article.rb"
    assert_selector "pre.code-card-body code", text: "class Article; end"
  end

  def test_renders_marked_up_code_from_a_block
    render_inline(Code::CodeCardComponent.new(filename: "x.rb")) do
      '<span class="tok-keyword">def</span> hi'.html_safe
    end

    assert_selector "pre.code-card-body code .tok-keyword", text: "def"
  end
end
