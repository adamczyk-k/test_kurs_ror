class TrainingCost < ApplicationRecord
  belongs_to :training
  belongs_to :resource_type
end
