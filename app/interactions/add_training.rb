class AddTraining < ActiveInteraction::Base
  object :user
  object :dragon
  object :training

  def execute
    training = DragonTraining.new(dragon_id: @dragon.id, training_id: @training.id, start_time: Time.now)
    pay_for_training if training.save
  end

  def pay_for_training
    resources = @training.resources_amount
    resources.each do |resource|
      user_resource = user.resources.find_by(resource_type: resource.resource_type.id)
      user_amount = user_resource.quantity
      user_resource.update_attribute(:quantity, user_amount - resource.cost)
    end
  end
end
