# frozen_string_literal: true

require "test_helper"

class Seo::MetaComponentTest < ViewComponent::TestCase
  def test_renders_title_description_open_graph_and_twitter_tags
    render_inline(Seo::MetaComponent.new(url: "https://railsyeah.test/"))

    assert_selector("title", text: Site::COURSE, visible: :all)
    assert_selector("meta[name='description'][content='#{Site::TAGLINE}']", visible: :all)
    assert_selector("meta[property='og:title'][content='#{Site::COURSE}']", visible: :all)
    assert_selector("meta[property='og:type'][content='website']", visible: :all)
    assert_selector("meta[property='og:url'][content='https://railsyeah.test/']", visible: :all)
    assert_selector("meta[property='og:image'][content='https://railsyeah.test/icon.png']", visible: :all)
    assert_selector("meta[name='twitter:card'][content='summary_large_image']", visible: :all)
  end

  def test_appends_brand_suffix_for_custom_titles
    render_inline(Seo::MetaComponent.new(url: "https://railsyeah.test/about", title: "About"))

    assert_selector("title", text: "About · #{Site::NAME}", visible: :all)
  end
end
