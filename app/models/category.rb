class Category < ApplicationRecord
  belongs_to :user
  validates :name, uniqueness: { scope: :user_id }, presence: true
end
