class ExpeditionsController < ApplicationController
  def index
    @expedition = current_user.expeditions
  end

  def show
    @expedition = @current_user.expeditions.find(params[:id])
    @prize_resources = ExpeditionPrize.where(expedition_type_id: @expedition.expedition_type)
  end

  def new
    @expedition = Expedition.new
  end

  def create
    @expedition = current_user.expeditions.build(expedition_params)

    if @expedition.save
      ExpeditionRemoveWorker.perform_at(5.seconds.from_now, @expedition.id, @expedition.expedition_type.id, current_user.id)
      flash[:notice] = 'Expedition came back!'
      redirect_to expeditions_index_path(current_user.id)
    else
      flash[:alert] = @expedition.errors.full_messages
    end
  end

  def destroy
    @expedition = Expedition.find(params[:id])
    claim_prize
    @expedition.destroy
    redirect_to expeditions_index_path(current_user.id)
  end

  private

  def claim_prize
    prize_resources = ExpeditionPrize.where(expedition_type_id: @expedition.expedition_type)
    prize_resources.each do |prize_resource|
      @resource = current_user.resources.find_by(resource_type: prize_resource.resource_type.id)
      user_amount = @resource.quantity
      @resource.update_attribute(:quantity, user_amount + prize_resource.prize)
    end
  end

  def expedition_params
    params.require(:expedition).permit(:dragon_id, :expedition_type_id)
  end
end
