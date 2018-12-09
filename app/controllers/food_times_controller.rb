class FoodTimesController < ApplicationController
  def new
    @dragon = params[:format]
  end

  def create
    @dragon = Dragon.find(params[:food_time][:dragon])
    @attribute = params[:food_time][:stat]
    flash[:alert] = FeedDragon.run!(dragon: @dragon, attribute: @attribute)

    redirect_to dragons_teams_index_path(current_user.id)
  end
end
