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
    # @dragon = current_user.dragon.build
  end

  def create
    dragon_type = DragonType.find(params[:dragons_team][:dragon_type_id])
    if current_user.dragons.count >= 5
      flash[:alert] = "You can't add more dragons"
    elsif !current_user.can_afford?(DragonType.find(dragon_type))
      flash[:alert] = current_user.missing_resources_for(dragon_type)
    else
      AddDragon.run!(user: current_user, dragon: Dragon.new(dragon_params))
    end
    redirect_to dragons_teams_index_path(current_user.id)
  end

  def destroy
    @dragon = Dragon.find(params[:id])
    @dragon.destroy
    redirect_to dragons_teams_index_path(current_user.id)
  end

  private

  def dragon_params
    params.require(:dragons_team).permit(:name, :level, :dragon_type_id, :description)
  end
end
