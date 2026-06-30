require "test_helper"

class LectureTest < ActiveSupport::TestCase
  test "requires a title" do
    lecture = Lecture.new(curriculum_section: curriculum_sections(:intro), lecture_type: "video")
    assert_not lecture.valid?
    assert_includes lecture.errors[:title], "can't be blank"
  end

  test "rejects an unknown lecture_type" do
    lecture = Lecture.new(curriculum_section: curriculum_sections(:intro), title: "Intro", lecture_type: "podcast")
    assert_not lecture.valid?
  end

  test "ordered scope sorts by position" do
    assert_equal lectures(:welcome), curriculum_sections(:intro).lectures.ordered.first
  end

  test "article? reflects the lecture type" do
    assert lectures(:source_code).article?
    assert_not lectures(:welcome).article?
  end

  test "rejects a video that is not an allowed type" do
    lecture = lectures(:welcome)
    lecture.video.attach(io: StringIO.new("not a video"), filename: "doc.txt", content_type: "text/plain")

    assert_not lecture.valid?
    assert_includes lecture.errors.attribute_names, :video
  end

  test "accepts a valid video" do
    lecture = lectures(:welcome)
    lecture.video.attach(io: StringIO.new("fake mp4 bytes"), filename: "clip.mp4", content_type: "video/mp4")

    assert lecture.valid?
  end
end
