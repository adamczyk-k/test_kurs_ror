class DragonsTeamsController < ApplicationController
  def index
    @view_model = UserHomePageViewModel.new
  end

  def show
    @view_model = UserHomePageViewModel.new
    @user = current_user
    @dragon = @user.dragons.find(params[:id])
  end

  def new
    @view_model = UserHomePageViewModel.new
    @user = current_user
    @dragon = Dragon.new
    @type_of_dragon = DragonType.find(params[:format])
    @dragon_cost = DragonCost.where(dragon_type: @type_of_dragon)
  end

  def create
    dragon_type = DragonType.find(params[:dragons_team][:dragon_type_id])
    process_dragon_creation(dragon_type)

    redirect_to dragons_teams_index_path(current_user.id)
  end

  def destroy
    @dragon = Dragon.find(params[:id])
    @dragon.destroy
    redirect_to dragons_teams_index_path(current_user.id)
  end

  private

  def process_dragon_creation(dragon_type)
    print current_user.dragons.all.size
    if current_user.reached_dragons_limit?
      flash[:alert] = "You can't add more dragons"
    elsif !current_user.can_afford?(dragon_type)
      flash[:alert] = current_user.missing_resources_for_error(dragon_type)
    else
      AddDragon.run!(user: current_user, dragon: Dragon.new(dragon_params))
    end
  end

  def dragon_params
    params.require(:dragons_team).permit(:name, :level, :dragon_type_id, :description)
  end
end
