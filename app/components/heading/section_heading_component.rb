# frozen_string_literal: true

# A standardized section intro (sidecar): an optional uppercase eyebrow, a bold
# Rails-red title, and optional supporting copy — the rubyonrails.org
# "Everything you need." pattern. Composes the design-system utilities from the
# theme overlay (.eyebrow / .heading-display / .text-accent / .lead-copy). (#2954)
class Heading::SectionHeadingComponent < ApplicationComponent
  LEVELS = (1..6).to_a.freeze
  ALIGNMENTS = %w[start center].freeze

  def initialize(title:, eyebrow: nil, copy: nil, level: 2, align: "start", accent: true)
    @title = title
    @eyebrow = eyebrow
    @copy = copy
    @level = LEVELS.include?(level) ? level : 2
    @align = ALIGNMENTS.include?(align.to_s) ? align.to_s : "start"
    @accent = accent
  end

  private

  attr_reader :title, :eyebrow, :copy, :level, :align, :accent

  def heading_tag
    "h#{level}"
  end

  def title_classes
    [ "heading-display", "mb-0", ("text-accent" if accent) ].compact.join(" ")
  end

  def copy_classes
    [ "lead-copy", "measure", "mt-3", "mb-0", ("mx-auto" if align == "center") ].compact.join(" ")
  end
end
