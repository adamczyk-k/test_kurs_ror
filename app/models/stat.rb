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

  def add_attribute(attribute)
    level_up_stat = []
    case attribute
    when 'Perception'
      update_attribute(:perception, perception + 1)
      level_up_stat = ['Perception', perception]
    when 'Strength'
      update_attribute(:strength, strength + 1)
      level_up_stat = ['Strength', strength]
    when 'Luck'
      update_attribute(:luck, luck + 1)
      level_up_stat = ['Luck', luck]
    end
    level_up_stat
  end
end
