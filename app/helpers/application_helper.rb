module ApplicationHelper
  # Tags/attributes Tiptap's StarterKit (+ Link) can produce. Admin-authored rich
  # text is rendered through Rails' sanitizer as defense-in-depth against stored
  # XSS, and so legacy plain-text content still renders cleanly. (#2947)
  RICH_TEXT_TAGS = %w[p br strong b em i s code pre h2 h3 ul ol li blockquote a].freeze
  RICH_TEXT_ATTRIBUTES = %w[href].freeze

  def rich_text(html)
    sanitize(html, tags: RICH_TEXT_TAGS, attributes: RICH_TEXT_ATTRIBUTES)
  end
end
