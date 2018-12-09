class FeedDragon < ActiveInteraction::Base
  object :dragon
  string :attribute

  def execute
    can_dragon_eat = can_dragon_eat?
    if can_dragon_eat
      feed_dragon
    else
      "You already fed #{dragon.name}"
    end
  end

  def feed_dragon
    level_up_stat = @dragon.stat.add_attribute(attribute)
    if level_up_stat.empty?
      "Stat #{attribute} doesn't exist"
    else
      food_time = FoodTime.new(dragon: @dragon, time: Time.now)
      food_time.save
      "You level up #{@dragon.name}'s #{level_up_stat[0]} to #{level_up_stat[1]}"
    end
  end

  def can_dragon_eat?
    last_food = FoodTime.find_by(dragon: @dragon)
    if last_food.nil?
      true
    elsif last_food.can_dragon_eat?
      last_food.destroy
      true
    else false
    end
  end
end
