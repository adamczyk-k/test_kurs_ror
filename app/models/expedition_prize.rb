class ExpeditionPrize < ApplicationRecord
  belongs_to :expedition_type
  belongs_to :resource_type
end
