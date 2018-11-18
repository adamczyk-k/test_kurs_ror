FactoryBot.define do
  factory :resource_type do
    sequence(:name) { |n| "resource_type#{n}" }
  end
end