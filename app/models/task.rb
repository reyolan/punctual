class Task < ApplicationRecord
  belongs_to :category
  scope :completed, -> { where(completed: true).order(:deadline) }
  scope :not_completed, -> { where(completed: false).order(:deadline) }
  validates :name, presence: true
end

