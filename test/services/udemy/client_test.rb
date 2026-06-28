require "test_helper"

module Udemy
  class ClientTest < ActiveSupport::TestCase
    test "course_stats maps the first course's fields" do
      client = Udemy::Client.new(token: "test-token")
      client.define_singleton_method(:taught_courses) do
        { "results" => [ { "rating" => 4.62, "num_reviews" => 82, "title" => "Course" } ] }
      end

      stats = client.course_stats

      assert_in_delta 4.62, stats[:rating], 0.001
      assert_equal 82, stats[:reviews_count]
      assert_equal "Course", stats[:title]
    end

    test "course_stats raises when no courses are returned" do
      client = Udemy::Client.new(token: "test-token")
      client.define_singleton_method(:taught_courses) { { "results" => [] } }

      assert_raises(Udemy::Client::Error) { client.course_stats }
    end

    test "raises a client error when the token is missing (no HTTP call)" do
      assert_raises(Udemy::Client::Error) { Udemy::Client.new(token: nil).course_stats }
    end
  end
end
