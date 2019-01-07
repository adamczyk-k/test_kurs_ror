FactoryBot.define do
  factory :dragon do
    sequence(:name) { |n| "dragon#{n}" }
    :dragon_type
  end
end
