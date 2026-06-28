# frozen_string_literal: true

# Landing-page hero (sidecar). A warm, rubyonrails.org-style hero: an eyebrow badge,
# a bold Rails-red course title, supporting copy, social proof, primary CTAs to the
# Udemy course, a clickable course-preview thumbnail, and an "at a glance" stat strip.
# Defaults come from the centralized Site config; content flows from HeroContent.
class Hero::HeroComponent < ApplicationComponent
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
