class HeroContent < ApplicationRecord
  validates :title, :cta_label, :cta_url, presence: true

  # Singleton-ish: the landing page renders the single configured hero.
  def self.current
    first
  end
end
