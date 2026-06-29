# frozen_string_literal: true

# Alternate landing-page hero (sidecar) — a Udemy/ZTM-style "course card" layout:
# course title + CTAs on the left, and a white card on the right holding the
# course-preview thumbnail plus an "at a glance" stat list. Used by the /v2 route;
# the primary hero (Hero::HeroComponent) is unchanged.
class Hero::CardHeroComponent < ApplicationComponent
  Stat = Data.define(:label, :value)

  def initialize(title: Site::COURSE, tagline: Site::TAGLINE, instructor: Site::INSTRUCTOR,
                 rating: Site::RATING, cta_text: "Enroll on Udemy", cta_url: Site::UDEMY_URL, image: nil)
    @title = title
    @tagline = tagline
    @instructor = instructor
    @rating = rating
    @cta_text = cta_text
    @cta_url = cta_url
    @image = image
  end

  private

  attr_reader :title, :tagline, :instructor, :rating, :cta_text, :cta_url, :image

  def stats
    [
      Stat.new("Rating", "#{rating} ★"),
      Stat.new("Lectures", Site::LECTURES.to_s),
      Stat.new("Video", Site::DURATION),
      Stat.new("Level", Site::LEVEL)
    ]
  end
end
