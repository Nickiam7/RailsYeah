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
