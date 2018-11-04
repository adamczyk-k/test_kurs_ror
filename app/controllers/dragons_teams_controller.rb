class DragonsTeamsController < ApplicationController
  def index
    @view_model = UserHomePageViewModel.new
    # @user = current_user
    # @dragon = Dragon.where(user: @user.id)
  end

  def show; end

  def new
    @view_model = UserHomePageViewModel.new
    @user = @view_model.current_user
    @dragon = Dragon.new
    # @dragon = current_user.dragon.build
  end

  def create
    @view_model = UserHomePageViewModel.new
    @user = @view_model.current_user
    # render plain: params[:dragons_team].inspect
    @dragon = @user.dragons.build(dragon_params)
    if @dragon.save
      render 'index'
    else
      puts @dragon.errors.full_messages
    end
  end

  private

  def dragon_params
    params.require(:dragons_team).permit(:name, :level, :dragon_type_id, :description)
  end
end
