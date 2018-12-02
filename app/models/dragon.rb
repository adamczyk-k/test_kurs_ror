class Dragon < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :dragon_type, optional: true
  has_one :stat, dependent: :destroy
end
