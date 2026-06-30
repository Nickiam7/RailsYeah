# frozen_string_literal: true

# Shared "Course Preview" modal: a featured video player plus a playlist of all
# preview videos — the hero course-preview video first, then every previewable
# lecture that has a video. Any preview video added to a lecture shows up here
# automatically. Triggers (data-bs-toggle="modal" + data-video-url) deep-link to a
# row; see video_modal_controller.js.
class Video::ModalComponent < ApplicationComponent
  Item = Data.define(:title, :duration, :url)

  # bi-play-circle
  PLAY_ICON = %(<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 16 16"><path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/><path d="M6.271 5.055a.5.5 0 0 1 .52.038l3.5 2.5a.5.5 0 0 1 0 .814l-3.5 2.5A.5.5 0 0 1 6 10.5v-5a.5.5 0 0 1 .271-.445"/></svg>).html_safe

  def initialize(hero_video: nil, sections: [])
    @hero_video = hero_video
    @sections = sections
  end

  private

  attr_reader :hero_video, :sections

  def course_title
    Site::COURSE
  end

  def items
    @items ||= [ featured_item, *lecture_items ].compact
  end

  def featured_item
    return unless hero_video&.attached?

    Item.new(course_title, nil, helpers.url_for(hero_video))
  end

  def lecture_items
    sections.flat_map do |section|
      section.lectures
             .select { |lecture| lecture.preview? && lecture.video.attached? }
             .map { |lecture| Item.new(lecture.title, lecture.duration, helpers.url_for(lecture.video)) }
    end
  end
end
