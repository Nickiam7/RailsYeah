# frozen_string_literal: true

require "test_helper"

class SeoFilesTest < ActionDispatch::IntegrationTest
  test "sitemap.xml is served as XML and lists the root url" do
    get "/sitemap.xml"

    assert_response :success
    assert_equal "application/xml", response.media_type
    assert_includes response.body, "<urlset"
    assert_includes response.body, "<loc>#{root_url}</loc>"
  end

  test "robots.txt allows crawling and references the sitemap" do
    get "/robots.txt"

    assert_response :success
    assert_equal "text/plain", response.media_type
    assert_match(/^User-agent: \*/, response.body)
    assert_match(%r{^Allow: /}, response.body)
    assert_includes response.body, "Sitemap: #{sitemap_url}"
  end
end
