class FeedDragon < ActiveInteraction::Base
  object :dragon
  object :attributes_type

  def execute
    can_dragon_eat = can_dragon_eat?
    if can_dragon_eat
      feed_dragon
    else
      "You already fed #{dragon.name}"
    end
  end

  def feed_dragon
    attribute = @dragon.get_attribute_by_type(attributes_type)
    attribute.add_attribute
    food_time = FoodTime.new(dragon: @dragon, time: Time.now)
    food_time.save
    "You level up #{@dragon.name}'s #{attribute.attributes_type.name} to #{attribute.level}"
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
