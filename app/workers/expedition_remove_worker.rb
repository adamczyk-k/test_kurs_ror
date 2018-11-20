class ExpeditionRemoveWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(expd, expdtypeid, usr)
    prize_resources = ExpeditionPrize.where(expedition_type_id: expdtypeid)
    prize_resources.each do |prize_resource|
      @resource = Resource.where(user_id: usr).find_by(resource_type: prize_resource.resource_type.id)
      user_amount = @resource.quantity
      @resource.update_attribute(:quantity, user_amount + prize_resource.prize)
    end
    Expedition.destroy(expd)
  end
end
