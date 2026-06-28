require "test_helper"

class TestimonialTest < ActiveSupport::TestCase
  test "requires name and quote" do
    testimonial = Testimonial.new
    assert_not testimonial.valid?
    assert_includes testimonial.errors.attribute_names, :name
    assert_includes testimonial.errors.attribute_names, :quote
  end

  test "rating must be 1..5 when present, but may be blank" do
    assert_not Testimonial.new(name: "A", quote: "B", rating: 9).valid?
    assert Testimonial.new(name: "A", quote: "B", rating: nil).valid?
  end

  test "published scope excludes unpublished records" do
    assert_includes Testimonial.published, testimonials(:published_one)
    assert_not_includes Testimonial.published, testimonials(:hidden)
  end

  test "rejects an avatar that is not an allowed image type" do
    testimonial = testimonials(:published_one)
    testimonial.avatar.attach(io: StringIO.new("not an image"), filename: "doc.txt", content_type: "text/plain")

    assert_not testimonial.valid?
    assert_includes testimonial.errors.attribute_names, :avatar
  end

  test "accepts a valid image avatar" do
    testimonial = testimonials(:published_one)
    testimonial.avatar.attach(io: StringIO.new("fake png bytes"), filename: "a.png", content_type: "image/png")

    assert testimonial.valid?
  end
end
