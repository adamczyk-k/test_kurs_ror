FactoryBot.define do
  factory :expedition_type do
    sequence(:name) { |n| "expedition_type#{n}" }
  end
end
