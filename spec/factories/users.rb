FactoryBot.define do
  factory :user do
    sequence(:user_name) { |n| "name_#{n}" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end