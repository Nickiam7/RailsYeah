# frozen_string_literal: true

# schema.org Course JSON-LD for the landing page (sidecar, under Seo::). Helps
# search engines understand the course, its provider (Udemy), instructor, and
# rating. The rating/review count default to the live-synced CourseStat (#2951),
# falling back to the Site defaults. Grouped under Seo:: for future engine extraction.
class Seo::CourseSchemaComponent < ApplicationComponent
  def initialize(url:, rating: CourseStat.rating_display, reviews_count: CourseStat.reviews_count)
    @url = url
    @rating = rating
    @reviews_count = reviews_count
  end

  # JSON-escaped (< etc.) so it is safe to embed inside a <script> tag.
  def json_ld
    ERB::Util.json_escape(JSON.generate(schema)).html_safe
  end

  private

  attr_reader :url, :rating, :reviews_count

  def schema
    {
      "@context": "https://schema.org",
      "@type": "Course",
      name: Site::COURSE,
      description: Site::TAGLINE,
      url: url,
      provider: { "@type": "Organization", name: "Udemy", url: "https://www.udemy.com" },
      author: { "@type": "Person", name: Site::INSTRUCTOR },
      aggregateRating: {
        "@type": "AggregateRating",
        ratingValue: rating,
        ratingCount: reviews_count,
        bestRating: "5",
        worstRating: "1"
      },
      offers: {
        "@type": "Offer",
        category: "Paid",
        url: Site::UDEMY_URL,
        availability: "https://schema.org/InStock"
      },
      hasCourseInstance: {
        "@type": "CourseInstance",
        courseMode: "online",
        courseWorkload: Site::WORKLOAD_ISO,
        instructor: { "@type": "Person", name: Site::INSTRUCTOR }
      }
    }
  end
end
