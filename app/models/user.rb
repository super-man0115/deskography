class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :posts
  has_one_attached :avatar

  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true
  validates :email, uniqueness: true
  validates :email, presence: true
  validates :user_name, presence: true, length: { maximum: 15 }

  def own?(object)
    id == object.user.id
  end  
end
