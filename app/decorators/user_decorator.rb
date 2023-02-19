class UserDecorator < Draper::Decorator
  delegate_all

  def avatar
    object.avatar.presence || 'default_avatar.png'
  end
end