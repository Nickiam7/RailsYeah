# frozen_string_literal: true

# FAQ section (sidecar). Renders published FAQ items as a Bootstrap accordion.
class Sections::FaqComponent < ApplicationComponent
  def initialize(items:)
    @items = items
  end

  def render?
    items.any?
  end

  private

  attr_reader :items
end
