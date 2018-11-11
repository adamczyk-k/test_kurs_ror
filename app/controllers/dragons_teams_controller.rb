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
    if current_user.dragons.count >= 5
      redirect_to dragons_teams_index_path(current_user.id)
    else
      add_dragon
    end
  end

  def destroy
    @dragon = Dragon.find(params[:id])
    @dragon.destroy
    redirect_to dragons_teams_index_path(current_user.id)
  end

  private

  def add_dragon
    @dragon = current_user.dragons.build(dragon_params)
    if @dragon.save
      render 'index'
    else
      flash[:alert] = @dragon.errors.full_messages
    end
  end

  def dragon_params
    params.require(:dragons_team).permit(:name, :level, :dragon_type_id, :description)
  end
end
