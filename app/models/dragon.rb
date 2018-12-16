class Dragon < ApplicationRecord
  include PgSearch
  pg_search_scope :search, against: 'name',
                           using: {
                             tsearch: { prefix: true, dictionary: 'english' }
                           }
  belongs_to :user, optional: true
  belongs_to :dragon_type, optional: true
  has_many :dragon_attribute, dependent: :destroy
  has_one :food_time, dependent: :destroy
  has_one :expedition, dependent: :destroy

  def get_attribute_by_name(attribute)
    DragonAttribute.where(dragon: self, attributes_type: AttributesType.where(name: attribute)).first
  end

  def get_attribute_by_type(attribute)
    DragonAttribute.where(dragon: self, attributes_type: attribute).first
  end

  def prize_from_training(prizes)
    levels_up = "#{name} levels up: "
    prizes.each do |prize|
      get_level_up(prize)
      levels_up += "#{prize.attributes_type.name} by #{prize.quantity}"
    end
    levels_up
  end

  def get_level_up(prize)
    attribute = get_attribute_by_type(prize.attributes_type)
    attribute = create_attribute(prize.attributes_type) if attribute.nil?
    attribute.update_attribute(:level, level + prize.quantity)
  end

  def create_attributes
    attributes_types = AttributesType.all
    attributes_types.each do |type|
      create_attribute(type)
    end
  end

  def create_attribute(attribute)
    dragon_attribute = DragonAttribute.new(attributes_type: attribute, dragon: self, level: 0)
    dragon_attribute.save
  end
end
