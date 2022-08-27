# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  belongs_to :category
  belongs_to :user
  has_one_attached :image

  aasm do
    state :draft, initial: true
    state :under_moderation, :published, :rejected, :archived

    event :moderate do
      transitions from: %i[draft rejected], to: :under_moderation
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :archive do
      transitions from: %i[draft under_moderation published rejected], to: :archived
    end
  end

  validates :title, length: { maximum: 50 }, presence: true
  validates :description, length: { maximum: 1000 }, presence: true
  validates :image, attached: true, content_type: ['image/png', 'image/jpeg', 'image/jpg'], size: { less_than: 5.megabytes }
end
