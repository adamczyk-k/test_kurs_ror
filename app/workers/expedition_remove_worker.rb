class ExpeditionRemoveWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(expd, expdtypeid, usr)
    claim(expd, expdtypeid, usr)
    Expedition.destroy(expd)
  end

  def claim(_expd, expdtypeid, usr)
    prize_resources = ExpeditionPrize.where(expedition_type_id: expdtypeid)
    prize_resources.each do |prize_rsrc|
      @resource = Resource.where(user_id: usr).find_by(resource_type: prize_rsrc.resource_type.id)
      add_resource(prize_rsrc.resource_type, usr) if @resource.nil?
      update_resource(prize_rsrc.prize)
    end
  end

  def add_resource(type, usr)
    @resource = Resource.new
    @resource.user_id = usr
    @resource.quantity = 0
    @resource.resource_type = type
  end

  def update_resource(prize)
    user_amount = @resource.quantity
    @resource.update_attribute(:quantity, user_amount + prize)
  end
end
