# frozen_string_literal: true

# schema.org Course JSON-LD for the landing page (sidecar, under Seo::). Helps
# search engines understand the course, its provider (Udemy), instructor, and
# rating. Grouped under Seo:: for future engine extraction.
class Seo::CourseSchemaComponent < ApplicationComponent
  def initialize(url:)
    @url = url
  end

  # JSON-escaped (< etc.) so it is safe to embed inside a <script> tag.
  def json_ld
    ERB::Util.json_escape(JSON.generate(schema)).html_safe
  end

  private

  attr_reader :url

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
        ratingValue: Site::RATING,
        ratingCount: Site::RATING_COUNT,
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
