class FoodTime < ApplicationRecord
  belongs_to :dragon

  def can_dragon_eat?
    DateTime.current >= time + 1.day
  end
end
