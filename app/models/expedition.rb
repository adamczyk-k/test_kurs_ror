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
    survive_chance = rand(0..100)
    survive_chance + (dragon.stat.strength / 10) >= DEATH_CHANCE
  end

  def kill_dragon
    destroy
    dragon.destroy
  end
end
