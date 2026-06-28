# frozen_string_literal: true

module Admin
  class DashboardController < BaseController
    def show
      @sections = [
        { name: "Hero", description: "Headline, tagline, and primary CTA.", path: edit_admin_hero_content_path },
        { name: "What you'll learn", description: "Learning-objective bullets.", path: admin_learning_objectives_path },
        { name: "Curriculum", description: "Course sections, lectures, and durations.", path: admin_curriculum_sections_path },
        { name: "Testimonials", description: "Student reviews and ratings.", path: admin_testimonials_path },
        { name: "FAQ", description: "Common questions about the course.", path: admin_faq_items_path },
        { name: "Instructor", description: "Instructor name, headline, and bio.", path: edit_admin_instructor_path }
      ]
    end
  end
end
