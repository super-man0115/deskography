class Item < ApplicationRecord
  has_many :post_items, dependent: :destroy
  has_many :posts, through: :post_items
  has_many :user_items, dependent: :destroy
  has_many :users, through: :user_items

  validates :item_code, presence: true

  def self.ransackable_associations(_auth_object = nil)
    super + ['items']
  end

  def self.ransackable_attributes(_auth_object = nil)
    ["created_at", "name", "updated_at", "caption", "maker"]
  end
end
