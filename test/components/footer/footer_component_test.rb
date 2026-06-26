# frozen_string_literal: true

require "test_helper"

class Footer::FooterComponentTest < ViewComponent::TestCase
  def test_renders_brand_instructor_copyright_and_udemy_link
    render_inline(Footer::FooterComponent.new)

    assert_selector("footer.site-footer")
    assert_text(Site::NAME)
    assert_text(Site::INSTRUCTOR)
    assert_text(Time.current.year.to_s)
    assert_link("View on Udemy", href: Site::UDEMY_URL)
  end
end
