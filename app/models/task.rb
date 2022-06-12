class Task < ApplicationRecord
  belongs_to :category
  default_scope -> { order(deadline: :asc) }
  validates :name, presence: true
end

