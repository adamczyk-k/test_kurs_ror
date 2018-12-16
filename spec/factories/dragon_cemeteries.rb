FactoryBot.define do
  factory :dragon_cemetery do
    name { "MyString" }
    user { nil }
    dragon_type { nil }
    level { 1 }
    cause_of_death { "MyText" }
  end
end
