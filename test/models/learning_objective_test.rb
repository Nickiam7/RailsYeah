require "test_helper"

class LearningObjectiveTest < ActiveSupport::TestCase
  test "requires a description" do
    assert_not LearningObjective.new.valid?
  end

  test "ordered scope sorts by position" do
    assert_equal [ learning_objectives(:one), learning_objectives(:two) ], LearningObjective.ordered.to_a
  end
end
