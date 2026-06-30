class CurriculumSection < ApplicationRecord
  has_many :lectures, -> { ordered }, dependent: :destroy

  validates :title, presence: true

  scope :ordered, -> { order(:position, :id) }
end
