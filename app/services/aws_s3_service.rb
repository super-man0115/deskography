require 'aws-sdk-s3'

s3 = Aws::S3::Resource.new(region: 'ap-northeast-1')
bucket = s3.bucket('deskographyapp')