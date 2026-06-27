# frozen_string_literal: true

require "test_helper"

class SeoMetaTagsTest < ActionDispatch::IntegrationTest
  test "home page head renders title, description, Open Graph and Twitter tags" do
    get root_path
    assert_response :success

    assert_select "head title", text: Site::COURSE
    assert_select "meta[name=description][content=?]", Site::TAGLINE
    assert_select "meta[property='og:title'][content=?]", Site::COURSE
    assert_select "meta[property='og:description'][content=?]", Site::TAGLINE
    assert_select "meta[property='og:type'][content=website]"
    assert_select "meta[property='og:url']"
    assert_select "meta[property='og:image']"
    assert_select "meta[name='twitter:card'][content=?]", "summary_large_image"
    assert_select "meta[name='twitter:title'][content=?]", Site::COURSE
  end
end
