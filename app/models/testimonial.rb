class Testimonial < ApplicationRecord
  validates :name, :quote, presence: true
  validates :rating, inclusion: { in: 1..5 }, allow_nil: true

  scope :published, -> { where(published: true) }
  scope :ordered, -> { order(:position, :id) }
end
