class DragonType < ApplicationRecord
  validates :name, presence: true,
                   length: { minimum: 5 }

  has_one :dragon_cost
end
