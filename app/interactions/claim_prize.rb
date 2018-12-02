class ClaimPrize < ActiveInteraction::Base
  object :user
  object :expedition

  def execute
    claim
    @expedition.destroy
  end

  def claim
    prize_resources = expedition.expedition_type.expedition_prizes
    prize_resources.each do |prize_rsrc|
      @resource = user.resources.find_by(resource_type: prize_rsrc.resource_type.id)
      add_resource(prize_rsrc.resource_type) if @resource.nil?
      update_resource(prize_rsrc.prize)
    end
  end

  def add_resource(type)
    @resource = Resource.new
    @resource.user = user
    @resource.quantity = 0
    @resource.resource_type = type
  end

  def update_resource(prize)
    dragon = expedition.dragon
    user_amount = @resource.quantity
    @resource.update_attribute(:quantity, user_amount + dragon.stat.add_bonus_from_perception(prize))
  end
end
