# frozen_string_literal: true

# A small pill badge / eyebrow chip (sidecar). Standardizes the uppercase label
# pills used across the landing page (e.g. "Udemy Course"). Variants map to the
# design-system palette tokens. (#2954)
class Badge::BadgeComponent < ApplicationComponent
  VARIANTS = %w[accent light dark].freeze

  def initialize(label:, variant: "accent")
    @label = label
    @variant = VARIANTS.include?(variant.to_s) ? variant.to_s : "accent"
  end

  private

  attr_reader :label, :variant

  def css_classes
    "badge-pill badge-pill-#{variant}"
  end
end
