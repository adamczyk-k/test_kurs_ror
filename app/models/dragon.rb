class Dragon < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :dragon_type, optional: true
  has_many :dragon_attribute, dependent: :destroy
  has_one :food_time, dependent: :destroy

  def get_attribute_by_name(attribute)
    DragonAttribute.where(dragon: self, attributes_type: AttributesType.where(name: attribute)).first
  end

  def get_attribute_by_type(attribute)
    DragonAttribute.where(dragon: self, attributes_type: attribute).first
  end
end
