class Task < ApplicationRecord
  belongs_to :category

  validates :name, presence: true

  scope :completed, -> { where(completed: true).order(:deadline) }
  scope :not_completed, -> { where(completed: false).order(:deadline) }
end
