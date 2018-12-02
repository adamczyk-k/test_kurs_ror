class Stat < ApplicationRecord
  belongs_to :dragon

  def add_bonus_from_perception(quantity)
    Integer(quantity * (1 + (perception / 100.00)))
  end

  def find_random_resource
    chance = rand(1..100)
    return nil if luck < chance

    choose_resource = rand(1..ResourceType.all.size)
    ResourceType.find_by(id: choose_resource)
  end
end
