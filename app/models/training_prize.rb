class TrainingPrize < ApplicationRecord
  belongs_to :training
  belongs_to :attributes_type
end
