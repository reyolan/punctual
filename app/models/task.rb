class Task < ApplicationRecord
  belongs_to :category

  validates :name, presence: true

  scope :not_completed_deadline_today, -> { not_completed.deadline_today.asc_name }
  scope :not_completed_deadline_not_today, -> { deadline_not_today.or(deadline_nil).not_completed.asc_deadline }
  scope :completed_asc_name, -> { completed.asc_name }

  scope :asc_deadline, -> { order(:deadline) }
  scope :asc_name, -> { order(:name) }
  scope :deadline_nil, -> { where(deadline: nil) }
  scope :deadline_not_today, -> { where.not(deadline: Date.current) }
  scope :deadline_today, -> { where(deadline: Date.current) }
  scope :completed, -> { where(completed: true) }
  scope :not_completed, -> { where(completed: false) }

  def complete
    update_attribute(:completed, true)
  end

  def uncomplete
    update_attribute(:completed, false)
  end
end
