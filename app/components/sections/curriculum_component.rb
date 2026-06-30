# frozen_string_literal: true

# Course content / curriculum section (sidecar). Expandable sections (Bootstrap
# accordion), each revealing its lectures.
class Sections::CurriculumComponent < ApplicationComponent
  # Static, inline Bootstrap Icons (bi-play-circle / bi-file-earmark-text).
  VIDEO_ICON = %(<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16"><path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/><path d="M6.271 5.055a.5.5 0 0 1 .52.038l3.5 2.5a.5.5 0 0 1 0 .814l-3.5 2.5A.5.5 0 0 1 6 10.5v-5a.5.5 0 0 1 .271-.445"/></svg>).html_safe
  ARTICLE_ICON = %(<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16"><path d="M5.5 7a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1zM5 9.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5m0 2a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5"/><path d="M9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4.5zm0 1v2A1.5 1.5 0 0 0 11 4.5h2V14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1z"/></svg>).html_safe

  def initialize(sections:)
    @sections = sections
  end

  def render?
    sections.any?
  end

  private

  attr_reader :sections

  def meta_for(section)
    count = section.lectures.size
    [
      count.positive? ? "#{count} lectures" : nil,
      section.duration.presence
    ].compact.join(" · ")
  end

  def lecture_icon(lecture)
    lecture.article? ? ARTICLE_ICON : VIDEO_ICON
  end

  # Course-wide totals shown beside the heading (from the Site config, matching the
  # hero stats).
  def totals
    "#{Site::LECTURES} lectures · #{Site::DURATION}"
  end
end
