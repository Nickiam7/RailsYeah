# frozen_string_literal: true

# Landing-page hero (sidecar). A warm, rubyonrails.org-style hero: an eyebrow badge,
# a bold Rails-red course title, supporting copy, social proof, primary CTAs to the
# Udemy course, a layered CodeCard visual, and an "at a glance" stat strip. Defaults
# come from the centralized Site config; content flows from HeroContent unchanged.
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

  # Static, hand-marked snippet for the hero CodeCard visual (course-flavored).
  # Constant markup only — no interpolation — rendered via Code::CodeCardComponent.
  def code_snippet
    <<~HTML.html_safe
      <span class="tok-keyword">class</span> <span class="tok-constant">Vault</span> &lt; <span class="tok-constant">ApplicationRecord</span>
        <span class="tok-method">has_many</span> <span class="tok-symbol">:credentials</span>, dependent: <span class="tok-symbol">:destroy</span>
        <span class="tok-method">encrypts</span> <span class="tok-symbol">:secret_key</span>
        <span class="tok-method">validates</span> <span class="tok-symbol">:name</span>, presence: <span class="tok-keyword">true</span>
      <span class="tok-keyword">end</span>
    HTML
  end
end
