class DragonCost < ApplicationRecord
  belongs_to :dragon_type
  belongs_to :resource_type
end
