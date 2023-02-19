FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "test_tag_name_#{n}" }
  end
end