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
    @user = @view_model.current_user
    @dragon = Dragon.new
    # @dragon = current_user.dragon.build
  end

  def create
    @view_model = UserHomePageViewModel.new
    @user = @view_model.current_user
    if @user.dragons.count >= 5
      render 'index'
    else
      add_dragon
    end
  end

  def destroy
    @view_model = UserHomePageViewModel.new
    @user = @view_model.current_user
    @dragon = Dragon.find(params[:id])
    @dragon.destroy
    redirect_to dragons_teams_index_path(@user.id)
  end

  private

  def add_dragon
    @dragon = @user.dragons.build(dragon_params)
    if @dragon.save
      render 'index'
    else
      puts @dragon.errors.full_messages
    end
  end

  def dragon_params
    params.require(:dragons_team).permit(:name, :level, :dragon_type_id, :description)
  end
end
