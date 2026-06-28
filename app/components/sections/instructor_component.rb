# frozen_string_literal: true

# Instructor section (sidecar). Renders the single instructor record.
class Sections::InstructorComponent < ApplicationComponent
  def initialize(instructor:)
    @instructor = instructor
  end

  def render?
    instructor.present?
  end

  private

  attr_reader :instructor
end
