class Item < ApplicationRecord
  has_many :post_items, dependent: :destroy
  has_many :posts, through: :post_items
  has_many :user_items, dependent: :destroy
  has_many :users, through: :user_items

  validates :item_code, presence: true
end
