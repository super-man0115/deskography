require 'aws-sdk-s3'

class AwsS3Service
  def initialize
    @s3 = Aws::S3::Resource.new(region: 'ap-northeast-1')
    @bucket = @s3.bucket('deskographyapp')
  end

  # ここにS3バケットを操作するメソッドを追加します
end