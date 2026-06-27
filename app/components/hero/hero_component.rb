# frozen_string_literal: true

# Landing-page hero (sidecar). Course title + tagline, social proof, a primary CTA
# to the Udemy course, and an "at a glance" stats card. Defaults come from the
# centralized Site config so the hero stays in sync with the rest of the site.
class Hero::HeroComponent < ApplicationComponent
  Stat = Data.define(:label, :value)

  def initialize(title: Site::COURSE, tagline: Site::TAGLINE, instructor: Site::INSTRUCTOR,
                 rating: Site::RATING, cta_text: "Enroll on Udemy", cta_url: Site::UDEMY_URL)
    @title = title
    @tagline = tagline
    @instructor = instructor
    @rating = rating
    @cta_text = cta_text
    @cta_url = cta_url
  end

  private

  attr_reader :title, :tagline, :instructor, :rating, :cta_text, :cta_url

  def stats
    [
      Stat.new("Rating", "#{rating} ★"),
      Stat.new("Lectures", Site::LECTURES.to_s),
      Stat.new("Video", Site::DURATION),
      Stat.new("Level", Site::LEVEL)
    ]
  end
end
