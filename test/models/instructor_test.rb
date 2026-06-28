require "test_helper"

class InstructorTest < ActiveSupport::TestCase
  test "requires a name" do
    assert_not Instructor.new.valid?
  end

  test ".current returns the first record" do
    assert_equal instructors(:main), Instructor.current
  end
end
