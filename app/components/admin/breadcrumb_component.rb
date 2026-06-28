# frozen_string_literal: true

# A small breadcrumb trail for the admin area (sidecar). The trail is derived from
# the current controller/action so every admin page gets one with no per-view
# boilerplate. Hidden on the dashboard itself (a lone "Dashboard" crumb is noise).
class Admin::BreadcrumbComponent < ApplicationComponent
  Crumb = Data.define(:label, :path)

  # controller_name => label + the path helper for the section's landing page.
  # Singletons (hero/instructor) have no index, so their section crumb is the page.
  SECTIONS = {
    "hero_contents" => { label: "Hero", helper: :edit_admin_hero_content_path, singleton: true },
    "instructors" => { label: "Instructor", helper: :edit_admin_instructor_path, singleton: true },
    "learning_objectives" => { label: "Learning objectives", helper: :admin_learning_objectives_path },
    "curriculum_sections" => { label: "Curriculum", helper: :admin_curriculum_sections_path },
    "testimonials" => { label: "Testimonials", helper: :admin_testimonials_path },
    "faq_items" => { label: "FAQ", helper: :admin_faq_items_path }
  }.freeze

  def initialize(controller_name:, action_name:)
    @controller_name = controller_name
    @action_name = action_name
  end

  def render?
    crumbs.size > 1
  end

  private

  attr_reader :controller_name, :action_name

  def crumbs
    @crumbs ||= build_crumbs
  end

  def build_crumbs
    section = SECTIONS[controller_name]
    return [ Crumb.new("Dashboard", nil) ] if section.nil?

    list = [ Crumb.new("Dashboard", admin_root_path) ]
    sub_page = !section[:singleton] && action_name.in?(%w[new edit])
    list << Crumb.new(section[:label], sub_page ? public_send(section[:helper]) : nil)
    list << Crumb.new(action_name == "new" ? "New" : "Edit", nil) if sub_page
    list
  end
end
