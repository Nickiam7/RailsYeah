# frozen_string_literal: true

# Top navigation bar for the marketing site (sidecar component).
#
# Responsive Bootstrap navbar: brand on the left, section links that collapse into
# a hamburger on small screens, and a primary CTA to the Udemy course on the right.
class Navbar::NavbarComponent < ApplicationComponent
  Link = Data.define(:label, :href)

  # Forward-looking anchors — the matching sections land in later landing-page stories.
  DEFAULT_LINKS = [
    Link.new("Overview", "#overview"),
    Link.new("What you'll learn", "#learn"),
    Link.new("Curriculum", "#curriculum"),
    Link.new("Reviews", "#reviews")
  ].freeze

  def initialize(brand: Site::NAME, links: DEFAULT_LINKS, cta_text: "Enroll on Udemy",
                 cta_url: Site::UDEMY_URL, signed_in: false)
    @brand = brand
    @links = links
    @cta_text = cta_text
    @cta_url = cta_url
    @signed_in = signed_in
  end

  private

  attr_reader :brand, :links, :cta_text, :cta_url, :signed_in
end
