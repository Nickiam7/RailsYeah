# frozen_string_literal: true

# Top navigation for the admin area (sidecar). Brand, links to content-management
# sections (placeholders until the Content Management epic wires the CRUD up), a
# "view site" link, and sign out. `user_email` is passed in so the component stays
# decoupled from the request/Warden and is testable in isolation.
class Admin::NavComponent < ApplicationComponent
  Link = Data.define(:label, :href)

  def initialize(user_email: nil)
    @user_email = user_email
  end

  private

  attr_reader :user_email

  # Forward-looking — these point at "#" until the content CRUD lands (#2944/#2945).
  def sections
    [
      Link.new("Hero", "#"),
      Link.new("Testimonials", "#"),
      Link.new("FAQ", "#"),
      Link.new("Curriculum", "#")
    ]
  end
end
