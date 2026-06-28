require "test_helper"

class AdminHeroContentTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup { sign_in users(:admin) }

  test "edit renders the hero form" do
    get edit_admin_hero_content_path

    assert_response :success
    assert_select "form"
  end

  test "update changes the hero and it reflects on the public landing page" do
    patch admin_hero_content_path, params: {
      hero_content: { title: "Brand New Title", subtitle: "New subtitle", cta_label: "Go", cta_url: "https://example.com" }
    }
    assert_redirected_to admin_root_path
    assert_equal "Brand New Title", HeroContent.current.title

    sign_out users(:admin)
    get root_path
    assert_select "h1", text: "Brand New Title"
  end
end
