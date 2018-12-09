class AddDragon < ActiveInteraction::Base
  object :user
  object :dragon

  def execute
    dragon.user = user
    pay_for_dragon if dragon.save
    create_attributes
  end

  def pay_for_dragon
    resources = dragon.dragon_type.resources_amount
    resources.each do |resource|
      user_resource = user.resources.find_by(resource_type: resource.resource_type.id)
      user_amount = user_resource.quantity
      user_resource.update_attribute(:quantity, user_amount - resource.cost)
    end
  end

  def create_attributes
    attributes_types = AttributesType.all
    attributes_types.each do |type|
      dragon_attribute = DragonAttribute.new(attributes_type: type, dragon: dragon, level: 0)
      dragon_attribute.save
    end
  end
end
