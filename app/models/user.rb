class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :dragons
  has_many :resources
  has_many :expeditions

  DRAGONS_LIMIT = 5

  # @param object_type [DragonType/DragonAttribute]
  # @return [Boolean]
  def can_afford?(object_type)
    missing_resources_for(object_type).empty?
  end

  # @param object_type [DragonType/DragonAttribute]
  # @return [Array<Hash>]
  def missing_resources_for(object_type)
    missing_resources = []
    object_type.resources_amount.each do |object_cost_resource|
      unless missing_quantity_of(object_cost_resource).nil?
        missing_resources << missing_quantity_of(object_cost_resource)
      end
    end
    missing_resources
  end

  # @param dragon_type [DragonType/DragonAttribute]
  # @return String
  def missing_resources_for_error(object_type)
    missing_resources = 'Lacking resources: '
    missing_resources_for(object_type).map do |missing_resource|
      missing_resources += "#{missing_resource[:quantity]} #{missing_resource[:resource].resource_type.name} "
    end
    missing_resources
  end

  def reached_dragons_limit?
    dragons.count >= DRAGONS_LIMIT
  end

  private

  # @param object_cost_resource [DragonCost/TrainingCost]
  # @return [nil, Hash<resource: DragonCost/TrainingCost, quantity: Integer>]
  def missing_quantity_of(object_cost_resource)
    user_amount = resources.find_by(resource_type: object_cost_resource.resource_type.id)
    if user_amount.nil?
      { resource: object_cost_resource, quantity: object_cost_resource.cost }
    elsif user_amount.quantity < object_cost_resource.cost
      { resource: object_cost_resource, quantity: object_cost_resource.cost - user_amount.quantity }
    end
  end
end
