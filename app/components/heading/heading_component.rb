# frozen_string_literal: true

# Sample component that proves the sidecar + namespacing convention.
#
# It lives at app/components/heading/heading_component.rb with its template
# (heading_component.html.erb) and preview alongside it. Render it with:
#
#   <%= render Heading::HeadingComponent.new(title: "Welcome", subtitle: "...") %>
class Heading::HeadingComponent < ApplicationComponent
  LEVELS = (1..6).to_a.freeze
  ALIGNMENTS = %w[start center end].freeze

  def initialize(title:, subtitle: nil, level: 1, align: "start")
    @title = title
    @subtitle = subtitle
    @level = LEVELS.include?(level) ? level : 1
    @align = ALIGNMENTS.include?(align.to_s) ? align.to_s : "start"
  end

  private

  attr_reader :title, :subtitle, :level, :align

  def heading_tag
    "h#{level}"
  end

  def wrapper_classes
    "mb-3 text-#{align}"
  end
end
