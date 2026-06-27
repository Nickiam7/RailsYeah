class User < ApplicationRecord
  # Admin-only CMS: public registration is intentionally disabled (:registerable
  # removed). Admins are created via db/seeds.rb or the console.
  # Other available modules: :confirmable, :lockable, :timeoutable, :trackable, :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable
end
