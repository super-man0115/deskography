FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "title_#{n}" }
    sequence(:description) { |n| "description_#{n}" }
    business_attribute { rand(0..10) }
    age_group { rand(0..5) }
    user

    after(:build) do |post|
      post.main_image.attach(io: File.open('spec/fixtures/test_default.png'), filename: 'test_default.png', content_type: 'image/png')
    end
  end
end