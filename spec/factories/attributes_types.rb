FactoryBot.define do
  factory :attributes_type do
    sequence(:name) { |n| "attributes_type#{n}" }
  end
end
