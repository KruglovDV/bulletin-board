class Category < ApplicationRecord
  has_many :bulletins, dependent: :destroy

  validates :name, presence: true
end
