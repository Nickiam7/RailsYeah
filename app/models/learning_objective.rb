class LearningObjective < ApplicationRecord
  validates :description, presence: true

  scope :ordered, -> { order(:position, :id) }
end
