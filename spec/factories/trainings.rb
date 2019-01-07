FactoryBot.define do
  factory :training do
    sequence(:name) { |n| "training#{n}" }
  end
end
