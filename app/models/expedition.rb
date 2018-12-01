class Expedition < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :dragon, optional: true
  belongs_to :expedition_type, optional: true
end
