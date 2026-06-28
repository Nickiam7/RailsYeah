# frozen_string_literal: true

# A presentational, rubyonrails.org-style code card (sidecar): a dark surface with
# a filename header bar and a code body. Purely visual, used in hero/section art.
#
# Pass plain code via `code:` (HTML-escaped) for a simply-themed block, or pass a
# content block with .tok-* spans for hand-marked syntax coloring (no JS highlighter
# / build step). (#2955)
class Code::CodeCardComponent < ApplicationComponent
  def initialize(filename:, code: nil)
    @filename = filename
    @code = code
  end

  private

  attr_reader :filename, :code

  def body
    content.presence || code
  end
end
