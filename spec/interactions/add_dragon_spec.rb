require 'rails_helper'

RSpec.describe AddDragon do
  describe '#pay_for_dragon' do
    let!(:user) { FactoryBot.create :user }
    let!(:dragon_type) { FactoryBot.create :dragon_type }
    let!(:dragon) { FactoryBot.create :dragon, dragon_type: dragon_type }

    context 'When dragon is for free' do
      it 'User should get new dragon' do
        AddDragon.run!(user: user, dragon: dragon)
        expect(user.dragons.last).to eq(dragon)
      end
    end

    context 'When User has to pay for dragon' do
      let!(:resource_type) { FactoryBot.create :resource_type }
      let!(:dragon_cost) { FactoryBot.create :dragon_cost, dragon_type: dragon_type, resource_type: resource_type, cost: 5 }
      let!(:resource) { FactoryBot.create :resource, user: user, resource_type: resource_type, quantity: 6 }
      let!(:resource_type2) { FactoryBot.create :resource_type }
      let!(:dragon_cost2) { FactoryBot.create :dragon_cost, dragon_type: dragon_type, resource_type: resource_type2, cost: 5 }
      let!(:resource2) { FactoryBot.create :resource, user: user, resource_type: resource_type2, quantity: 5 }

      it 'when user pay with only one resource' do
        AddDragon.run!(user: user, dragon: dragon)
        expect(user.dragons.first).to eq(dragon)
        expect(resource.reload.quantity).to eq(1)
      end

      it 'when user pay with many resources' do
        AddDragon.run!(user: user, dragon: dragon)
        expect(user.dragons.last).to eq(dragon)
        expect(resource.reload.quantity).to eq(1)
        expect(resource2.reload.quantity).to eq(0)
      end
    end
  end
end
