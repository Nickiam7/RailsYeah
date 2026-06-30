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
  headline: "Senior Software Engineer / Ruby on Rails instructor",
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
  { title: "Introduction", duration: "13min", lectures: [
    { title: "Important. Please Watch.", duration: "1:41", preview: true },
    { title: "What We're Going to Build", duration: "8:32", preview: true },
    { title: "Source Code", duration: "0:45", lecture_type: "article" },
    { title: "Development Setup", duration: "2:30", lecture_type: "article" }
  ] },
  { title: "Creating our Ruby on Rails Application", duration: "20min", lectures: [
    { title: "Running Rails New and Starting our Server", duration: "9:23", preview: true },
    { title: "Pages Controller, Routing and Views", duration: "5:10", preview: true },
    { title: "View - Navbar Partial and Links", duration: "5:37" }
  ] },
  { title: "Authentication", duration: "1hr 6min", lectures: [
    { title: "Installing and Configuring Devise", duration: "9:12" },
    { title: "Generating the User Model and Views", duration: "11:40" },
    { title: "Sign Up, Sign In, and Sign Out", duration: "12:30", preview: true },
    { title: "Restricting Access with Before Actions", duration: "10:05" },
    { title: "Styling the Authentication Pages", duration: "13:20" },
    { title: "Current User Helpers and Flash Messages", duration: "9:13" }
  ] },
  { title: "Creating our Entry Resource", duration: "49min", lectures: [
    { title: "Scaffolding the Entry Model", duration: "6:10" },
    { title: "Strong Params and Controller Actions", duration: "5:25" },
    { title: "Entry Forms and Validations", duration: "7:02" },
    { title: "Encrypting Sensitive Attributes", duration: "6:40", preview: true },
    { title: "Listing and Searching Entries", duration: "5:50" },
    { title: "Showing and Editing an Entry", duration: "4:35" },
    { title: "Deleting Entries with Turbo", duration: "4:10" },
    { title: "Scoping Entries to the Current User", duration: "5:08" },
    { title: "Adding Copy-to-Clipboard", duration: "4:30" }
  ] },
  { title: "Hotwire - Converting to a Single Page Application (SPA)", duration: "1hr 38min", lectures: [
    { title: "What is Hotwire?", duration: "5:20", preview: true },
    { title: "Turbo Drive Basics", duration: "6:15" },
    { title: "Turbo Frames Introduction", duration: "7:40" },
    { title: "Editing Entries in a Turbo Frame", duration: "8:05" },
    { title: "Lazy-Loading Frames", duration: "6:30" },
    { title: "Turbo Streams Introduction", duration: "7:55" },
    { title: "Creating Records with Turbo Streams", duration: "8:20" },
    { title: "Updating and Destroying with Streams", duration: "7:10" },
    { title: "Broadcasting Changes", duration: "8:45" },
    { title: "Flash Messages over Turbo Streams", duration: "6:25" },
    { title: "Stimulus Controllers Introduction", duration: "7:35" },
    { title: "Wiring Up a Stimulus Controller", duration: "6:50" },
    { title: "Polishing the SPA Experience", duration: "5:30" }
  ] },
  { title: "More Hotwire - Turbo and Stimulus JS", duration: "41min", lectures: [
    { title: "Stimulus Values and Targets", duration: "8:10" },
    { title: "Building a Toggle Controller", duration: "7:45" },
    { title: "Debouncing Search with Stimulus", duration: "9:20" },
    { title: "Keyboard Shortcuts with Stimulus", duration: "7:35" },
    { title: "Reusable Stimulus Patterns", duration: "8:30" }
  ] },
  { title: "Secure JSON API With JWT", duration: "34min", lectures: [
    { title: "Namespacing an API with Versioning", duration: "5:05", preview: true },
    { title: "JWT Authentication Overview", duration: "6:20" },
    { title: "Encoding and Decoding Tokens", duration: "6:00" },
    { title: "Authenticating API Requests", duration: "5:40" },
    { title: "Serializing JSON Responses", duration: "5:35" },
    { title: "Handling API Errors", duration: "5:20" }
  ] },
  { title: "Chrome Extension - SafePass Intro", duration: "19min", lectures: [
    { title: "Anatomy of a Chrome Extension", duration: "5:10", preview: true },
    { title: "The Manifest File", duration: "3:15", lecture_type: "article" },
    { title: "Popup UI and Structure", duration: "5:40" },
    { title: "Loading the Unpacked Extension", duration: "4:45" }
  ] },
  { title: "Chrome Extension - Authentication", duration: "30min", lectures: [
    { title: "Calling the JWT API from the Extension", duration: "8:20" },
    { title: "Storing the Token Securely", duration: "7:35" },
    { title: "Login and Logout Flow", duration: "7:50" },
    { title: "Handling Expired Sessions", duration: "6:15" }
  ] },
  { title: "Chrome Extension - Entries", duration: "42min", lectures: [
    { title: "Fetching Entries from the API", duration: "7:10" },
    { title: "Rendering the Entry List", duration: "6:45" },
    { title: "Reading the Active Tab URL", duration: "6:30" },
    { title: "Autofilling Form Fields", duration: "7:55", preview: true },
    { title: "Copying Passwords from the Popup", duration: "6:40" },
    { title: "Final Build and Wrap-Up", duration: "6:50" }
  ] }
].each_with_index do |attrs, i|
  section = CurriculumSection.find_or_create_by!(title: attrs[:title])
  section.update!(duration: attrs[:duration], position: i)

  attrs[:lectures].each_with_index do |lecture_attrs, j|
    section.lectures.find_or_create_by!(title: lecture_attrs[:title]) do |lecture|
      lecture.assign_attributes(lecture_attrs.reverse_merge(lecture_type: "video", preview: false).merge(position: j))
    end
  end
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
