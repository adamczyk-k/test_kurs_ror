class DragonsTeamController < ApplicationController
  def index
    @view_model = UserHomePageViewModel.new
    # @user = current_user
    # @dragon = Dragon.where(user: @user.id)
  end

  def show; end

  def new
    @dragon = current_user.dragon.build
  end

  def create
    # @dragon = current_user.dragon.build(dragon_params)
  end
end
