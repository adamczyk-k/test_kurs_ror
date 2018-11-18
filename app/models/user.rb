class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :dragons
  has_many :resources
  has_many :expeditions

  def can_afford?(dragon_type)
    resources_list = DragonCost.resources_amount(dragon_type)
    resources_list.each do |resource|
      user_amount = resources.find_by(resource_type: resource.resource_type.id)
      if !resource?(user_amount) || !good_amount?(user_amount, resource)
        return false
      end
    end
    true
  end

  def missing_resources_for(dragon_type)
    missing_resources = 'Lacking resources: '
    resources_list = DragonCost.resources_amount(dragon_type)
    resources_list.each do |resource|
      user_amount = resources.find_by(resource_type: resource.resource_type.id)
      if !resource?(user_amount)
        missing_resources += "#{resource.cost} #{resource.resource_type.name} "
      elsif !good_amount?(user_amount, resource)
        missing_resources += "#{resource.cost - user_amount.quantity} #{resource.resource_type.name} "
      end
    end
    missing_resources
  end

  def resource?(resource)
    return false if resource.nil?

    true
  end

  def good_amount?(user_amount, resource)
    user_amount.quantity - resource.cost >= 0
  end
end
