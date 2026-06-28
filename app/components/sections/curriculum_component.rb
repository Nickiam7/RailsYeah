# frozen_string_literal: true

# Course content / curriculum section (sidecar). Lists curriculum sections.
class Sections::CurriculumComponent < ApplicationComponent
  def initialize(sections:)
    @sections = sections
  end

  def render?
    sections.any?
  end

  private

  attr_reader :sections

  def meta_for(section)
    [
      section.lectures_count && "#{section.lectures_count} lectures",
      section.duration.presence
    ].compact.join(" · ")
  end
end
