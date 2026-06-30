# frozen_string_literal: true

require "test_helper"

class Video::ModalComponentTest < ViewComponent::TestCase
  def test_renders_the_modal_shell_without_videos
    render_inline(Video::ModalComponent.new)

    assert_selector "#videoModal.modal[data-controller='video-modal']"
    assert_selector "video[data-video-modal-target='player']"
    assert_selector "[data-video-modal-target='empty']", text: "Preview coming soon.", visible: false
    assert_text "Course Preview"
    assert_no_selector ".video-modal-item"
  end

  def test_lists_the_hero_and_previewable_lecture_videos
    hero = HeroContent.create!(title: "T", subtitle: "S", cta_label: "Enroll", cta_url: "https://example.com")
    hero.video.attach(io: StringIO.new("v"), filename: "promo.mp4", content_type: "video/mp4")

    section = CurriculumSection.create!(title: "Intro", position: 0)
    previewable = section.lectures.create!(title: "Lesson One", duration: "1:41", preview: true, lecture_type: "video")
    previewable.video.attach(io: StringIO.new("v"), filename: "lesson.mp4", content_type: "video/mp4")
    section.lectures.create!(title: "No Clip", preview: true, lecture_type: "video") # previewable, but no video

    render_inline(Video::ModalComponent.new(hero_video: hero.video, sections: [ section ]))

    # Course preview (hero) + the one previewable lecture that has a video.
    assert_selector ".video-modal-item", count: 2
    assert_selector ".video-modal-item-title", text: Site::COURSE
    assert_selector ".video-modal-item-title", text: "Lesson One"
    assert_selector ".video-modal-item-duration", text: "1:41"
    assert_no_text "No Clip"
  end
end
