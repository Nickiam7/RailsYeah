class CurriculumSection < ApplicationRecord
  validates :title, presence: true

  scope :ordered, -> { order(:position, :id) }
end
