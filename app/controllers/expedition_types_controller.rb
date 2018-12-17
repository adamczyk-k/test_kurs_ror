class ExpeditionTypesController < ApplicationController
  def index
    @expedition_type = ExpeditionType.all
  end

  def show
    @expedition_type = ExpeditionType.find(params[:id])
    @prize_resources = ExpeditionPrize.where(expedition_type_id: @expedition_type)
  end

  private

  def expedition_type_params
    params.require(:expedition_types).permit(:name, :description, :longevity, :experience)
  end
end
