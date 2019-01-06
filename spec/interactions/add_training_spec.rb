require 'rails_helper'

RSpec.describe AddTraining do
  describe '#pay_for_training' do
    let!(:user) { FactoryBot.create :user }
    let!(:dragon_type) { FactoryBot.create :dragon_type }
    let!(:dragon) { FactoryBot.create :dragon, dragon_type: dragon_type }
    let!(:resource_type) { FactoryBot.create :resource_type }
    let!(:training) { FactoryBot.create :training }
    let!(:training_cost) { FactoryBot.create :training_cost, training: training, resource_type: resource_type, cost: 5 }

    let!(:resource_type) { FactoryBot.create :resource_type }
    let!(:resource) { FactoryBot.create :resource, user: user, resource_type: resource_type, quantity: 6 }
    let!(:resource_type2) { FactoryBot.create :resource_type }
    let!(:resource2) { FactoryBot.create :resource, user: user, resource_type: resource_type2, quantity: 5 }

    it 'when user pay with only one resource' do
      AddTraining.run!(user: user, dragon: dragon, training: training)
      expect(Training.last).to eq(training)
      expect(resource.reload.quantity).to eq(1)
    end

    context 'when training costs many resources' do
      let!(:training_cost2) { FactoryBot.create :training_cost, training: training, resource_type: resource_type2, cost: 5 }

      it 'when user pay with many resources' do
        AddTraining.run!(user: user, dragon: dragon, training: training)
        expect(Training.last).to eq(training)
        expect(resource.reload.quantity).to eq(1)
        expect(resource2.reload.quantity).to eq(0)
      end
    end
  end
end
