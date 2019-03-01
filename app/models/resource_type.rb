class ResourceType < ApplicationRecord
  validates :name, presence: true,
                   length: { minimum: 3 }
  has_one_attached :thumbnail
end
