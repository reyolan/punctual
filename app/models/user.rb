class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable, :confirmable
  has_many :categories, dependent: :destroy
  has_many :tasks, through: :categories
end
