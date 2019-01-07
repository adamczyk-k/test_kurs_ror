require 'rails_helper'

RSpec.describe Expedition do
  describe '#resolve_expedition' do
    let!(:user) { FactoryBot.create :user }
    let!(:dragon_type) { FactoryBot.create :dragon_type }
    let!(:dragon) { FactoryBot.create :dragon, user: user }
    let!(:expedition_type) { FactoryBot.create :expedition_type }
    let!(:expedition) { FactoryBot.create :expedition, expedition_type: expedition_type, dragon: dragon, user: user }

    context 'When dragon dies at expedition' do
      it do
        expect(user.dragons.size).to eq(1)
        expedition.kill_dragon
        expect(DragonTombstone.all.size).to eq(1)
        expect(user.dragons.size).to eq(0)
      end
    end
  end
end
