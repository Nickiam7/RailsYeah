# frozen_string_literal: true

module Admin
  class DashboardController < BaseController
    def show
      @sections = [
        { name: "Hero", description: "Headline, tagline, and primary CTA." },
        { name: "Testimonials", description: "Student reviews and ratings." },
        { name: "FAQ", description: "Common questions about the course." },
        { name: "Curriculum", description: "Sections, lectures, and the instructor." }
      ]
    end
  end
end
