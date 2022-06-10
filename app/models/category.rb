class Category < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  default_scope -> { order(:name) }
  validates :name, uniqueness: { scope: :user_id }, presence: true, length: { maximum: 24 }
end
