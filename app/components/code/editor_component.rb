# frozen_string_literal: true

# A tabbed, VS Code-style code "editor" (sidecar): a dark panel with a tab bar of
# files and switchable code panes (Bootstrap tabs via importmap — no build step).
# Each file responds to #filename and #code (html_safe, hand-marked .tok-* spans).
class Code::EditorComponent < ApplicationComponent
  def initialize(files:)
    @files = files
    @uid = "editor-#{SecureRandom.hex(4)}"
  end

  private

  attr_reader :files, :uid

  def basename(filename)
    filename.split("/").last
  end

  # File-type key for the tab's color dot (rb / js / css / ...).
  def language(filename)
    ::File.extname(filename).delete(".").presence || "txt"
  end
end
