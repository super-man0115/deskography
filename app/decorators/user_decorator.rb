class UserDecorator < Draper::Decorator
  delegate_all

  def avatar
    object.avatar.attached? ? object.avatar : object.default_avatar
  end
end