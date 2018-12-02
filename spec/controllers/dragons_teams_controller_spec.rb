require 'rails_helper'

RSpec.describe DragonsTeamsController do
  let(:dragon_type) { FactoryBot.create :dragon_type }
  let(:user) { FactoryBot.create :user }

  before do
    sign_in user
  end

  describe 'POST #create' do
    subject { post :create, params: { dragons_team: { name: 'Name', level: 0, dragon_type_id: dragon_type.id, description: 'test' } } }
    it do
      expect { subject }.to change { user.dragons.reload.size }.by(1)
    end

    context 'with dragons limit' do
      let!(:dragon) { FactoryBot.create :dragon, user: user, dragon_type: dragon_type }
      let!(:dragon1) { FactoryBot.create :dragon, user: user, dragon_type: dragon_type }
      let!(:dragon2) { FactoryBot.create :dragon, user: user, dragon_type: dragon_type }
      let!(:dragon3) { FactoryBot.create :dragon, user: user, dragon_type: dragon_type }
      let!(:dragon4) { FactoryBot.create :dragon, user: user, dragon_type: dragon_type }
      it do
        user.reload
        expect { subject }.to change { user.dragons.reload.size }.by(0)
        expect(flash[:alert]).to eq("You can't add more dragons")
      end
    end

    context 'with lacking resource' do
      let!(:resource_type) { FactoryBot.create :resource_type }
      let!(:dragon_cost) { FactoryBot.create :dragon_cost, dragon_type: dragon_type, resource_type: resource_type, cost: 5 }
      it do
        expect { subject }.to change { user.dragons.reload.size }.by(0)
        expect(flash[:alert]).to eq("Lacking resources: #{dragon_cost.cost} #{dragon_cost.resource_type.name} ")
      end
    end
  end
end
