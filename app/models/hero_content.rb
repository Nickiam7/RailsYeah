class HeroContent < ApplicationRecord
  include ImageAttachable
  include VideoAttachable

  validates :title, :cta_label, :cta_url, presence: true
  attached_image :image
  attached_video :video

  # Singleton-ish: the landing page renders the single configured hero.
  def self.current
    first
  end
end
