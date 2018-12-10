class DragonAttribute < ApplicationRecord
  belongs_to :dragon
  belongs_to :attributes_type

  def add_bonus_from_perception(quantity)
    Integer(quantity * (1 + (level / 100.00)))
  end

  def find_random_resource
    chance = rand(1..100)
    return nil if level < chance

    choose_resource = ResourceType.all.sample
    ResourceType.find_by(id: choose_resource.id)
  end

  def add_attribute
    update_attribute(:level, level + 1)
  end
end
