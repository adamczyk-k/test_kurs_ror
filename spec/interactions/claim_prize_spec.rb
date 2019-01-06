require 'rails_helper'

RSpec.describe ClaimPrize do
  describe '#claim' do
    let!(:user) { FactoryBot.create :user }
    let!(:dragon_type) { FactoryBot.create :dragon_type }
    let!(:dragon) { FactoryBot.create :dragon, dragon_type: dragon_type }
    let!(:expedition_type) { FactoryBot.create :expedition_type }
    let!(:resource_type) { FactoryBot.create :resource_type }
    let!(:expedition_prize) { FactoryBot.create :expedition_prize, expedition_type: expedition_type, resource_type: resource_type, prize: 5 }
    let!(:expedition) { FactoryBot.create :expedition, expedition_type: expedition_type, dragon: dragon, user: user }
    let!(:perception_type) { FactoryBot.create :attributes_type, name: 'Perception' }
    let!(:luck_type) { FactoryBot.create :attributes_type, name: 'Luck' }
    let!(:strength_type) { FactoryBot.create :attributes_type, name: 'Strength' }

    context 'When dragon has no bonus' do
      it 'dragon will receive normal prize' do
        ClaimPrize.run!(user: user, expedition: expedition)
        expect(user.resources.last.quantity).to eq(5)
      end
    end
  end
end
