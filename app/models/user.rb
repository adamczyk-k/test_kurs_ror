class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :dragons
  has_many :resources
  has_many :expeditions

  DRAGONS_LIMIT = 5

  # @param dragon_type [DragonType]
  # @return [Boolean]
  def can_afford?(dragon_type)
    missing_resources_for(dragon_type).empty?
  end

  # @param dragon_type [DragonType]
  # @return [Array<Hash>]
  def missing_resources_for(dragon_type)
    missing_resources = []
    dragon_type.resources_amount.each do |dragon_cost_resource|
      missing_resources << missing_quantity_of(dragon_cost_resource)
    end
    missing_resources
  end

  # @param dragon_type [DragonType]
  # @return String
  def missing_resources_for_error(dragon_type)
    missing_resources = 'Lacking resources: '
    missing_resources_for(dragon_type).map do |missing_resource|
      missing_resources += "#{missing_resource[:quantity]} #{missing_resource[:resource].resource_type.name} "
    end
    missing_resources
  end

  def reached_dragons_limit?
    dragons.count >= DRAGONS_LIMIT
  end

  private

  # @param dragon_cost_resource [DragonCost]
  # @return [nil, Hash<resource: DragonCost, quantity: Integer>]
  def missing_quantity_of(dragon_cost_resource)
    user_amount = resources.find_by(resource_type: dragon_cost_resource.resource_type.id)
    if user_amount.nil?
      { resource: dragon_cost_resource, quantity: dragon_cost_resource.cost }
    elsif user_amount.quantity < dragon_cost_resource.cost
      { resource: dragon_cost_resource, quantity: dragon_cost_resource.cost - user_amount.quantity }
    end
  end
end
