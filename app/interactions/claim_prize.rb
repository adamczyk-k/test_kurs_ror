class ClaimPrize < ActiveInteraction::Base
  object :user
  object :expedition

  def execute
    prize = claim
    @expedition.destroy
    prize
  end

  def claim
    prize = 'Your prize: '
    prize += "Experience: #{add_exp_to_user} "
    prize += basic_prize
    bonus_res = add_bonus_resource
    prize += "#{bonus_res[1]} #{bonus_res[0].resource_type.name}" unless bonus_res.nil?
    prize
  end

  def basic_prize
    prize = ''
    prize_resources = @expedition.expedition_type.expedition_prizes
    prize_resources.each do |prize_rsrc|
      add_basic_resource(prize_rsrc)
      prize += ", #{prize_rsrc.prize} #{prize_rsrc.resource_type.name} "
    end
    prize
  end

  def add_exp_to_user
    exp_gain = expedition.expedition_type.experience
    user_exp = user.experience
    user.update_attribute(:experience, user_exp + exp_gain)
    user_exp
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
    @resource.update_attribute(:quantity, user_amount + dragon.get_attribute_by_name('Perception').add_bonus_from_perception(prize))
  end

  def add_bonus_resource
    dragon = expedition.dragon
    resource = dragon.get_attribute_by_name('Luck').find_random_resource
    return if resource.nil?

    @resource = user.resources.find_by(id: resource)
    add_resource(resource) if @resource.nil?
    update_resource(10)
    [resource, 10]
  end

  private

  def add_basic_resource(prize_rsrc)
    @resource = user.resources.find_by(resource_type: prize_rsrc.resource_type.id)
    add_resource(prize_rsrc.resource_type) if @resource.nil?
    update_resource(prize_rsrc.prize)
  end
end
