class DragonType < ApplicationRecord
  validates :name, presence: true,
                   length: { minimum: 5 }
  has_one_attached :thumbnail

  has_one :dragon_cost

  def resources_amount
    @resource_type = DragonCost.where(dragon_type_id: self)
    @resource_type
  end
end
