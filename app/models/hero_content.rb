class HeroContent < ApplicationRecord
  include ImageAttachable

  validates :title, :cta_label, :cta_url, presence: true
  attached_image :image

  # Singleton-ish: the landing page renders the single configured hero.
  def self.current
    first
  end
end
