class Resource < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :resource_type, optional: true
end
