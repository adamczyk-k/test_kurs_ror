class ExpeditionsController < ApplicationController
  def index
    @expedition = current_user.expeditions
    @expedition_types = ExpeditionType.where(ExpeditionType.arel_table[:user_level].lteq(current_user.level))
    @expedition_blocked = ExpeditionType.where(ExpeditionType.arel_table[:user_level].gt(current_user.level))
  end

  def show
    @expedition = @current_user.expeditions.find(params[:id])
    @prize_resources = ExpeditionPrize.where(expedition_type_id: @expedition.expedition_type)
  end

  def new
    @expedition = Expedition.new
    @expedition_type = ExpeditionType.find(params[:format])
  end

  def create
    @dragon = Dragon.find(params[:expedition][:dragon_id])
    flash[:alert] = resolve_expedition
    redirect_to expeditions_index_path(current_user.id)
  end

  def destroy
    expedition = Expedition.find(params[:id])
    alert = expedition.resolve_expedition
    flash[:alert] = alert unless alert.nil?
    redirect_to expeditions_index_path(current_user.id)
  end

  private

  def resolve_expedition
    assignment = @dragon.busy?
    if assignment.empty?
      create_expedition
    else
      assignment
    end
  end

  def create_expedition
    @expedition = current_user.expeditions.build(expedition_params)
    @expedition.start_time = DateTime.now
    if @expedition.save
      'You sent Expedition!'
      # claim_worker
    else
      @expedition.errors.full_messages
    end
  end

  def claim_worker
    ExpeditionRemoveWorker.perform_at(10.seconds.from_now, @expedition.id, @expedition.expedition_type.id, current_user.id)
    flash[:notice] = 'Expedition came back!'
  end

  def expedition_params
    params.require(:expedition).permit(:dragon_id, :expedition_type_id, :start_time)
  end
end
