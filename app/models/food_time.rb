class FoodTime < ApplicationRecord
  belongs_to :dragon

  def can_dragon_eat?
    Time.now >= time + 1.day
  end
end
