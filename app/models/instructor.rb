class Instructor < ApplicationRecord
  validates :name, presence: true

  # Singleton-ish: the landing page renders the single configured instructor.
  def self.current
    first
  end
end
