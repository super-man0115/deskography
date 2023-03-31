class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_posts, through: :bookmarks, source: :post
  has_many :comment_bookmarks, dependent: :destroy
  has_many :comment_bookmark_users, through: :comment_bookmarks, source: :comment
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
  has_one_attached :avatar

  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true
  validates :email, uniqueness: true
  validates :user_name, presence: true, length: { maximum: 50 }

  def own?(object)
    id == object.user.id
  end

  def bookmark(post)
    bookmark_posts << post
  end
  
  def unbookmark(post)
    bookmark_posts.destroy(post)
  end
  
  def bookmark?(post)
    bookmark_posts.include?(post)
  end

  def comment_bookmark(comment)
    comment_bookmark_users << comment
  end
  
  def comment_unbookmark(comment)
    comment_bookmarks.find_by(comment_id: comment.id).destroy
  end
  
  def comment_bookmark?(comment)
    comment_bookmark_users.include?(comment)
  end
end
