class DragonTypesController < ApplicationController
  def index
    @dragon_type = DragonType.all
  end

  def show
    @dragon_type = DragonType.find(params[:id])
    @resources = DragonCost.where(dragon_type: @dragon_type)
  end

  private

  def dragon_type_params
    params.require(:dragon_types).permit(:name, :description)
  end
end
