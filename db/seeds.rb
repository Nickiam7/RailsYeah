# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Admin user for the CMS. There is no public sign-up, so the first admin is seeded.
# Set the credentials via `bin/rails credentials:edit` (admin: email:/password:).
# Dev/test fall back to a default; production requires the credential to be set.
admin_email = Rails.application.credentials.dig(:admin, :email) || "admin@example.com"
admin_password = Rails.application.credentials.dig(:admin, :password) ||
                 (Rails.env.local? ? "password123456" : nil)
raise "Set admin credentials (admin: email:/password:) via `bin/rails credentials:edit`" if admin_password.blank?

admin = User.find_or_initialize_by(email: admin_email)
admin.password = admin_password if admin.new_record?
admin.admin = true
admin.save!
puts "Seeded admin user: #{admin.email}"

# ---------------------------------------------------------------------------
# Landing-page content (editable via the admin in a later story). Idempotent.
# ---------------------------------------------------------------------------
HeroContent.first_or_create!(
  title: Site::COURSE,
  subtitle: Site::TAGLINE,
  cta_label: "Enroll on Udemy",
  cta_url: Site::UDEMY_URL
)

Instructor.first_or_create!(
  name: Site::INSTRUCTOR,
  headline: "Ruby on Rails instructor",
  bio: "Nick builds full-stack Ruby on Rails applications and teaches the modern, " \
       "Hotwire-first way to ship them — from secure JSON APIs to browser extensions."
)

[
  "Build a single-codebase Rails app that serves a web UI and a secure JSON API",
  "Create a secure JSON API with JWT authentication",
  "Use Hotwire (Turbo and Stimulus) to build an SPA-like experience",
  "Use Hotwire outside of a Ruby on Rails application",
  "Build a Google Chrome extension that consumes the Rails JSON API",
  "Autofill form data from the current site with the Chrome Extension API",
  "Apply Ruby on Rails best practices throughout"
].each_with_index do |description, i|
  LearningObjective.find_or_create_by!(description: description) { |o| o.position = i }
end

[
  { title: "Introduction", lectures_count: 4, duration: "13min" },
  { title: "Creating our Ruby on Rails Application", lectures_count: 3, duration: "20min" },
  { title: "Authentication", lectures_count: 6, duration: "1hr 6min" },
  { title: "Creating our Entry Resource", lectures_count: 9, duration: "49min" },
  { title: "Hotwire - Converting to a Single Page Application (SPA)", lectures_count: 13, duration: "1hr 38min" },
  { title: "More Hotwire - Turbo and Stimulus JS", lectures_count: 5, duration: "41min" },
  { title: "Secure JSON API With JWT", lectures_count: 6, duration: "34min" },
  { title: "Chrome Extension - SafePass Intro", lectures_count: 4, duration: "19min" },
  { title: "Chrome Extension - Authentication", lectures_count: 4, duration: "30min" },
  { title: "Chrome Extension - Entries", lectures_count: 6, duration: "42min" }
].each_with_index do |attrs, i|
  CurriculumSection.find_or_create_by!(title: attrs[:title]) { |c| c.assign_attributes(attrs.merge(position: i)) }
end

[
  { name: "Alex P.", role: "Backend Developer", rating: 5,
    quote: "The Hotwire sections finally made Turbo and Stimulus click for me. Building the SPA without a JS framework was eye-opening." },
  { name: "Priya S.", role: "Full-stack Engineer", rating: 5,
    quote: "Loved that we built a real product end to end — the JWT API and the Chrome extension tied everything together." },
  { name: "Marcus L.", role: "Rails Developer", rating: 4,
    quote: "Clear, practical, and modern. The best Rails 8 + Hotwire walkthrough I've found." }
].each_with_index do |attrs, i|
  Testimonial.find_or_create_by!(name: attrs[:name]) { |t| t.assign_attributes(attrs.merge(position: i)) }
end

[
  { question: "Do I need prior Rails experience?",
    answer: "Basic Ruby and Ruby on Rails experience is recommended, along with basic HTML, CSS, and JavaScript." },
  { question: "What will I build?",
    answer: "A full password manager called SafePass — a Rails web app, a secure JSON API, and a Google Chrome extension that consumes it." },
  { question: "Does the course cover Hotwire?",
    answer: "Yes. You'll use Turbo and Stimulus to build an SPA-like experience, including using Hotwire outside of a Rails app." },
  { question: "How long is the course?",
    answer: "About 7.5 hours of video across 12 sections and 69 lectures." }
].each_with_index do |attrs, i|
  FaqItem.find_or_create_by!(question: attrs[:question]) { |f| f.assign_attributes(attrs.merge(position: i)) }
end

puts "Seeded landing-page content."
