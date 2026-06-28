# frozen_string_literal: true

require "net/http"

module Udemy
  # Thin client for the Udemy Instructor API v1 (https://www.udemy.com/instructor-api/v1).
  #
  # Confirmed live (#2951): the taught-courses endpoint returns `rating` and
  # `num_reviews` for the instructor's course(s). Lecture count / duration / level
  # are NOT exposed there, so those stay in the content models / Site config.
  # Auth is a bearer token from credentials (udemy: api_token:).
  class Client
    Error = Class.new(StandardError)

    BASE_URI = "https://www.udemy.com/instructor-api/v1"

    def initialize(token: Rails.application.credentials.dig(:udemy, :api_token))
      @token = token
    end

    # => { rating: Float, reviews_count: Integer, title: String }
    def course_stats
      course = taught_courses.fetch("results", []).first
      raise Error, "no taught courses returned" if course.nil?

      {
        rating: course["rating"],
        reviews_count: course["num_reviews"],
        title: course["title"]
      }
    end

    private

    attr_reader :token

    def taught_courses
      get("/taught-courses/courses/?fields[course]=rating,num_reviews,title&page_size=1")
    end

    def get(path)
      raise Error, "missing Udemy API token" if token.blank?

      uri = URI("#{BASE_URI}#{path}")
      request = Net::HTTP::Get.new(uri)
      request["Authorization"] = "Bearer #{token}"
      request["Accept"] = "application/json"

      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true, open_timeout: 5, read_timeout: 10) do |http|
        http.request(request)
      end

      raise Error, "Udemy API returned #{response.code}" unless response.code.to_i == 200

      JSON.parse(response.body)
    rescue SocketError, SystemCallError, Timeout::Error, OpenSSL::SSL::SSLError, JSON::ParserError => e
      raise Error, "request failed: #{e.class}: #{e.message}"
    end
  end
end
