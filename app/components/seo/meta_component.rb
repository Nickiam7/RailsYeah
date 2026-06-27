# frozen_string_literal: true

# Renders the SEO <head> meta for a page: <title>, meta description, Open Graph,
# and Twitter card tags. Defaults pull from Site; per-page overrides come from the
# Seo::Metadata controller concern. Grouped under Seo:: for future engine extraction.
class Seo::MetaComponent < ApplicationComponent
  def initialize(url:, title: Site::COURSE, description: Site::TAGLINE,
                 image_url: Site::OG_IMAGE, type: "website", twitter_card: "summary_large_image")
    @url = url
    @title = title
    @description = description
    @image_url = image_url
    @type = type
    @twitter_card = twitter_card
  end

  private

  attr_reader :url, :title, :description, :type, :twitter_card

  # The home title (the course) stands alone; other pages get a brand suffix.
  def full_title
    title == Site::COURSE ? title : "#{title} · #{Site::NAME}"
  end

  # Social images must be absolute URLs.
  def image_url
    return if @image_url.blank?
    return @image_url if @image_url.start_with?("http")

    URI.join(url, @image_url).to_s
  end
end
