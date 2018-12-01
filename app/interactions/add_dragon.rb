class AddDragon < ActiveInteraction::Base
  object :user
  object :dragon

  def execute
    dragon.user = user
    pay_for_dragon if dragon.save
  end

  def pay_for_dragon
    resources = dragon.dragon_type.resources_amount
    resources.each do |resource|
      user_resource = user.resources.find_by(resource_type: resource.resource_type.id)
      user_amount = user_resource.quantity
      user_resource.update_attribute(:quantity, user_amount - resource.cost)
    end
  end
end
