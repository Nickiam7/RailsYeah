# frozen_string_literal: true

# "What you'll learn" section (sidecar). Renders learning objectives from the model.
class Sections::LearnComponent < ApplicationComponent
  def initialize(objectives:)
    @objectives = objectives
  end

  def render?
    objectives.any?
  end

  private

  attr_reader :objectives
end
