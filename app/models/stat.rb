class Stat < ApplicationRecord
  belongs_to :dragon

  def add_bonus_from_perception(quantity)
    Integer(quantity * (1 + perception/100.00))
  end

  def find_random_item
    chance = rand(1..100)
    print chance
    print ResourceType.all.size
    if luck >= chance
      choose_resource = rand(0...ResourceType.all.size)
      ResourceType.find_by(choose_resource)
    end
  end
end
