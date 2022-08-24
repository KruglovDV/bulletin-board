# frozen_string_literal: true

class Bulletin < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_one_attached :image

  validates :title, length: { maximum: 50 }, presence: true
  validates :description, length: { maximum: 1000 }, presence: true
  validates :image, attached: true, content_type: ['image/png', 'image/jpeg', 'image/jpg'], size: { less_than: 5.megabytes }
end
