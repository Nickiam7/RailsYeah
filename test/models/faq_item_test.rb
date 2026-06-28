require "test_helper"

class FaqItemTest < ActiveSupport::TestCase
  test "requires question and answer" do
    item = FaqItem.new
    assert_not item.valid?
    assert_includes item.errors.attribute_names, :question
    assert_includes item.errors.attribute_names, :answer
  end

  test "published scope excludes unpublished records" do
    assert_includes FaqItem.published, faq_items(:published_one)
    assert_not_includes FaqItem.published, faq_items(:hidden)
  end
end
