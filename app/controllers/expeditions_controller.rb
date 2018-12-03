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
    @expedition.start_time = DateTime.now
    if @expedition.save
      flash[:notice] = 'You sent Expedition!'
      # claim_worker
      redirect_to expeditions_index_path(current_user.id)
    else
      flash[:alert] = @expedition.errors.full_messages
    end
  end

  def destroy
    ClaimPrize.run!(user: current_user, expedition: Expedition.find(params[:id]))
    redirect_to expeditions_index_path(current_user.id)
  end

  private

  def claim_worker
    ExpeditionRemoveWorker.perform_at(10.seconds.from_now, @expedition.id, @expedition.expedition_type.id, current_user.id)
    flash[:notice] = 'Expedition came back!'
  end

  def expedition_params
    params.require(:expedition).permit(:dragon_id, :expedition_type_id, :start_time)
  end
end
