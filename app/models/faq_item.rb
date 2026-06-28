class FaqItem < ApplicationRecord
  validates :question, :answer, presence: true

  scope :published, -> { where(published: true) }
  scope :ordered, -> { order(:position, :id) }
end
