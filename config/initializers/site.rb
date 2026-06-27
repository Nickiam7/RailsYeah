# frozen_string_literal: true

# App-wide marketing/site constants. Centralized here so the navbar, footer, hero,
# and SEO tags (meta, Open Graph, JSON-LD) all draw from one source of truth.
# Likely migrates into an SEO engine / editable content models later in the sprint.
module Site
  NAME       = "Ruby on Rails 8 & Hotwire"
  COURSE     = "Ruby on Rails 8 and Hotwire: Build a Password Manager"
  TAGLINE    = "Build a modern full-stack Ruby on Rails app with a secure JSON API and a Google Chrome extension."
  INSTRUCTOR = "Nick McNeany"
  UDEMY_URL  = "https://www.udemy.com/course/ruby-on-rails-8-and-hotwire-build-a-password-manager/"
  GITHUB_URL = "https://github.com/Nickiam7"

  # Course facts (from the Udemy listing). Used in the hero "at a glance" card and,
  # later, JSON-LD structured data. Inline for V1; becomes editable content later.
  RATING       = "4.7"
  RATING_COUNT = 81
  SECTIONS     = 12
  LECTURES     = 69
  DURATION     = "7h 22m"
  LEVEL        = "All Levels"
end
