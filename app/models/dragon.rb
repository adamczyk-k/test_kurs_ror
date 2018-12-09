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

  def prize_from_training(prizes)
    levels_up = "#{self.name} levels up: "
    prizes.each do |prize|
      get_level_up(prize)
      levels_up += "#{prize.attributes_type.name} by #{prize.quantity}"
    end
    levels_up
  end

  def get_level_up(prize)
    attribute = get_attribute_by_type(prize.attributes_type)
    attribute.update_attribute(:level, level + prize.quantity)
  end
end
