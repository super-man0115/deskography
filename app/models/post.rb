class Post < ApplicationRecord
  belongs_to :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :comments, dependent: :destroy
  has_one_attached :main_image
  has_many_attached :sub_images
  
  validates :title, length: { maximum: 10 }
  validates :description, length: { maximum: 255 }
  validates :main_image, attached_file_presence: true
  validates :sub_images, attached_file_number: { maximum: 9 }

  enum :business_attribute, {
    engineer: 0, designer: 1, writer: 2, customer_support: 3, sales: 4, back_officer: 5, consultant: 6, marketer: 7, project_manager: 8, investor: 9, other: 10
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
end
