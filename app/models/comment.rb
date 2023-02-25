class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :comment_bookmarks, dependent: :destroy
  has_many :comment_bookmark_users, through: :comment_bookmarks, source: :comment

  validates :body, presence: true, length: { maximum: 65_535 }
end
