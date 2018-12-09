class FoodTimesController < ApplicationController
  def new
    @dragon = params[:format]
  end

  def create
    @dragon = Dragon.find(params[:food_time][:dragon])
    @attribute = params[:food_time][:stat]
    can_dragon_eat = can_dragon_eat?
    if can_dragon_eat
      flash[:alert] = feed_dragon
    else
      flash[:alert] = "You already feed #{@dragon.name}"
    end
    redirect_to dragons_teams_index_path(current_user.id)
  end

  def can_dragon_eat?
    last_food = FoodTime.find_by(dragon: @dragon)
    last_food.nil? || last_food.can_dragon_eat?
  end

  private

  def feed_dragon
    level_up_stat = @dragon.stat.add_attribute(@attribute)
    if level_up_stat.empty?
      "Stat #{@attribute} doesn't exist"
    else
      food_time = FoodTime.new(dragon: @dragon, time: Time.now)
      food_time.save
      "You level up #{@dragon.name}'s #{level_up_stat[0]} to #{level_up_stat[1]}"
    end
  end
end
