class Task < ApplicationRecord
  belongs_to :category
  belongs_to :user
  default_scope -> { order(deadline: :asc) }
  validates :name, presence: true
end

