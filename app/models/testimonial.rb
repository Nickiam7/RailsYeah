class Testimonial < ApplicationRecord
  include ImageAttachable

  validates :name, :quote, presence: true
  validates :rating, inclusion: { in: 1..5 }, allow_nil: true
  attached_image :avatar

  scope :published, -> { where(published: true) }
  scope :ordered, -> { order(:position, :id) }
end
