# frozen_string_literal: true

# Site footer (sidecar component). Brand blurb, quick links, instructor, and a CTA
# back to the Udemy course, with a copyright line.
class Footer::FooterComponent < ApplicationComponent
  def initialize(brand: Site::NAME, tagline: Site::TAGLINE, instructor: Site::INSTRUCTOR,
                 udemy_url: Site::UDEMY_URL, github_url: Site::GITHUB_URL)
    @brand = brand
    @tagline = tagline
    @instructor = instructor
    @udemy_url = udemy_url
    @github_url = github_url
  end

  private

  attr_reader :brand, :tagline, :instructor, :udemy_url, :github_url

  def year
    Time.current.year
  end
end
