class Lecture < ApplicationRecord
  TYPES = %w[video article].freeze

  belongs_to :curriculum_section

  validates :title, presence: true
  validates :lecture_type, inclusion: { in: TYPES }

  scope :ordered, -> { order(:position, :id) }

  def article?
    lecture_type == "article"
  end
end
