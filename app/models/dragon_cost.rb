class DragonCost < ApplicationRecord
  belongs_to :dragon_type
  belongs_to :resource_type

  def self.resources_amount(dragon_type)
    @resource_type = DragonCost.where(dragon_type_id: dragon_type)
    @resource_type
  end
end
