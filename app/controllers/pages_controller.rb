# Public marketing landing page. Renders its sections from the editable content
# models (#2944); each section component hides itself when its data is empty.
class PagesController < ApplicationController
  def home
    @hero = HeroContent.current
    @objectives = LearningObjective.ordered
    @curriculum = CurriculumSection.ordered.includes(:lectures)
    @testimonials = Testimonial.published.ordered
    @faqs = FaqItem.published.ordered
    @instructor = Instructor.current
  end
end
