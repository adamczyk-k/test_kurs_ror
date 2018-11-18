FactoryBot.define do
  factory :dragon_type do
    sequence(:name) { |n| "dragon_type#{n}" }
  end
end
