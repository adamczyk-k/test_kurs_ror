class Expedition < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :dragon, optional: true
  belongs_to :expedition_type, optional: true

  DEATH_CHANCE = 5

  def resolve_expedition
    if dragon_survive?
      ClaimPrize.run!(user: user, expedition: self)
      ''
    else
      alert = "Your dragon #{dragon.name} didn't survive expedition to #{expedition_type.name}"
      kill_dragon
      alert
    end
  end

  def dragon_survive?
    strength = dragon.get_attribute_by_name('Strength')
    survive_chance = rand(0..100)
    survive_chance + (strength.level / 10) >= DEATH_CHANCE
  end

  def kill_dragon
    dead_dragon = DragonTombstone.create(dragon.attributes)
    dead_dragon.update_attribute(:description, "Died #{Time.now} on expedition to #{expedition_type.name}")
    dragon.destroy if dead_dragon.save
    destroy
  end
end
