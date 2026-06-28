require "test_helper"

class CurriculumSectionTest < ActiveSupport::TestCase
  test "requires a title" do
    assert_not CurriculumSection.new.valid?
  end

  test "ordered scope sorts by position then id" do
    assert_equal CurriculumSection.order(:position, :id).to_a, CurriculumSection.ordered.to_a
  end
end
