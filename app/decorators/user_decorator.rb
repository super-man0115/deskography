class UserDecorator < Draper::Decorator
  delegate_all

  def avatar
    if object.avatar.attached?
      object.avatar
    else
      default_avatar
    end
  end

  private

  def default_avatar
    ActiveStorage::Blob.create_and_upload!(
      io: URI.open('https://deskographyapp.s3.ap-northeast-1.amazonaws.com/default_avatar.png'),
      filename: 'default_avatar.png'
    ).signed_id
  end
end