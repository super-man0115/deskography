class Post < ApplicationRecord
  belongs_to :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_posts, through: :bookmarks, source: :post
  has_many :post_items, dependent: :destroy
  has_many :items, through: :post_items
  has_many_attached :images

  validates :description, length: { maximum: 555 }
  validates :images, attached_file_presence: true
  validates :images, attached_file_number: { maximum: 10 }

  scope :items_name_cont, ->(value) { joins(:items).where('items.name LIKE ?', "%#{value}%") }
  scope :items_caption_cont, ->(value) { joins(:items).where('items.caption LIKE ?', "%#{value}%") }
  scope :items_maker_cont, ->(value) { joins(:items).where('items.maker LIKE ?', "%#{value}%") }

  enum :business_attribute, {
    engineer: 0, designer: 1, writer: 2, customer_support: 3, sales: 4, back_officer: 5, consultant: 6, marketer: 7, project_manager: 8, investor: 9, apprentice: 10, other: 10
  }

  enum :age_group, {
    twenties: 0, thirties: 1, forties: 2, fifties: 3, sixties_over: 4, secret: 5
  }


  def save_with_tags(tag_names:)
    ActiveRecord::Base.transaction do
      self.tags = tag_names.map { |name| Tag.find_or_initialize_by(name: name.strip) }
      save!
    end
    true
  rescue StandardError
    false
  end

  def tag_names
    tags.map(&:name).join(',')
  end

  def like_count
    bookmark_posts.count
  end

  def comment_like_count
    comment_bookmark_users.count
  end

  def self.ransackable_attributes(_auth_object = nil)
    ["age_group", "business_attribute", "created_at", "id", "updated_at", "user_id"]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["tags", "items"]
  end
end
