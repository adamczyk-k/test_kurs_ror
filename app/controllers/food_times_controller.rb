class FoodTimesController < ApplicationController
  def new
    @dragon = params[:format]
  end

  def create
    @dragon = Dragon.find(params[:food_time][:dragon])
    @attribute = AttributesType.find(params[:food_time][:attributes_type_id])
    flash[:alert] = FeedDragon.run!(dragon: @dragon, attributes_type: @attribute)

    redirect_to dragons_teams_index_path(current_user.id)
  end
end
