class Training < ApplicationRecord
  has_many :training_cost, dependent: :destroy
  has_many :training_prize, dependent: :destroy

  def resources_amount
    @resource_type = TrainingCost.where(training_id: self)
    @resource_type
  end
end
