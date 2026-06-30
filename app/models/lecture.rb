class Lecture < ApplicationRecord
  include VideoAttachable

  TYPES = %w[video article].freeze

  belongs_to :curriculum_section

  attached_video :video

  validates :title, presence: true
  validates :lecture_type, inclusion: { in: TYPES }

  scope :ordered, -> { order(:position, :id) }

  def article?
    lecture_type == "article"
  end
end
