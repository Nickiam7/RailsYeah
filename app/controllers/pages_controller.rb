# Public marketing landing page. Renders its sections from the editable content
# models (#2944); each section component hides itself when its data is empty.
class PagesController < ApplicationController
  def home
    load_landing_content
  end

  # Alternate landing-page layout (course-card hero) at /v2 — same content as home.
  def v2
    load_landing_content
  end

  private

  def load_landing_content
    @hero = HeroContent.current
    @objectives = LearningObjective.ordered
    @curriculum = CurriculumSection.ordered
    @testimonials = Testimonial.published.ordered
    @faqs = FaqItem.published.ordered
    @instructor = Instructor.current
  end
end
