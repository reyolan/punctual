class Task < ApplicationRecord
  belongs_to :category

  validates :name, presence: true

  scope :completed, -> { where(completed: true) }
  scope :not_completed, -> { where(completed: false) }
  scope :eager_load_tasks, -> { tasks.includes(:category) }
end
