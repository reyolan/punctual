class Category < ApplicationRecord
  belongs_to :user
  has_many :tasks
  validates :name, uniqueness: { scope: :user_id }, presence: true
end
