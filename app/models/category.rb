class Category < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  scope :asc_name, -> { order(:name) }
  validates :name, uniqueness: { scope: :user_id }, presence: true, length: { maximum: 24 }
end
