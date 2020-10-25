class Product < ApplicationRecord
  validates :title, presence: true
  belongs_to :user
  scope :by_title, ->(title) { where('title like ?', "%#{title}%") if title.present? }
end

