class Bulletin < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :title, length: { maximum: 50 }, presence: true
  validates :description, length: { maximum: 1000 }, presence: true
end
