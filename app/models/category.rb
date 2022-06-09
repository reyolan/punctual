class Category < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  default_scope -> { order(created_at: :asc) }
  validates :name, uniqueness: { scope: :user_id }, presence: true
end
