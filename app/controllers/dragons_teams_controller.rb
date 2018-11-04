class DragonsTeamsController < ApplicationController
  def index
    @view_model = UserHomePageViewModel.new
    # @user = current_user
    # @dragon = Dragon.where(user: @user.id)
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
      @dragon = @user.dragons.build(dragon_params)
      if @dragon.save
        render 'index'
      else
        puts @dragon.errors.full_messages
      end
    end
  end

  def destroy
    @dragon_type = Dragon.find(params[:id])
    @dragon_type.destroy
    render 'index'
  end

  private

  def dragon_params
    params.require(:dragons_team).permit(:name, :level, :dragon_type_id, :description)
  end
end
