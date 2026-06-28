require "test_helper"

class HeroContentTest < ActiveSupport::TestCase
  test "requires title, cta_label, and cta_url" do
    hero = HeroContent.new
    assert_not hero.valid?
    assert_includes hero.errors.attribute_names, :title
    assert_includes hero.errors.attribute_names, :cta_label
    assert_includes hero.errors.attribute_names, :cta_url
  end

  test ".current returns the first record" do
    assert_equal hero_contents(:main), HeroContent.current
  end
end
