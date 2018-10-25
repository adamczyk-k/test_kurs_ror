class DragonTypesController < ApplicationController
  def new; end

  def index
    @dragon_type = DragonType.all
  end

  def show
    @dragon_type = DragonType.find(params[:id])
  end

  def create
    # render plain: params[:dragon_types].inspect
    # @dragon_type = DragonType.new(params[:dragon_types])
    @dragon_type = DragonType.new(dragon_type_params)
    @dragon_type.save
    redirect_to @dragon_type
  end

  private

  def dragon_type_params
    params.require(:dragon_types).permit(:name, :description)
  end
end