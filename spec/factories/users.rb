FactoryBot.define do
  factory :user do
    sequence(:user_name) { |n| "name_#{n}" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    avatar { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test_avatar.png')) }
  end
end