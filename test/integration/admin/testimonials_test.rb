require "test_helper"

class AdminTestimonialsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup { sign_in users(:admin) }

  test "index lists testimonials" do
    get admin_testimonials_path

    assert_response :success
    assert_match testimonials(:published_one).name, response.body
  end

  test "creates a testimonial" do
    assert_difference -> { Testimonial.count }, 1 do
      post admin_testimonials_path, params: { testimonial: { name: "New Person", quote: "Great course", rating: 5 } }
    end

    assert_redirected_to admin_testimonials_path
  end

  test "rejects an invalid testimonial" do
    assert_no_difference -> { Testimonial.count } do
      post admin_testimonials_path, params: { testimonial: { name: "", quote: "" } }
    end

    assert_response :unprocessable_entity
  end

  test "updates a testimonial" do
    patch admin_testimonial_path(testimonials(:published_one)), params: { testimonial: { name: "Renamed" } }

    assert_redirected_to admin_testimonials_path
    assert_equal "Renamed", testimonials(:published_one).reload.name
  end

  test "destroys a testimonial" do
    assert_difference -> { Testimonial.count }, -1 do
      delete admin_testimonial_path(testimonials(:published_one))
    end
  end

  test "non-admins are denied" do
    sign_out users(:admin)
    sign_in users(:member)

    get admin_testimonials_path
    assert_redirected_to root_path
  end

  test "guests are redirected to sign in" do
    sign_out users(:admin)

    get admin_testimonials_path
    assert_redirected_to new_user_session_path
  end
end
