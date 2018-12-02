require 'rails_helper'

RSpec.describe DragonsTeamsController do
  let(:dragon_type) { FactoryBot.create :dragon_type }
  # let(:resource_type) { FactoryBot.create :resource_type }
  # let(:dragon_cost) { FactoryBot.create :dragon_cost, dragon_type: dragon_type, resource_type: resource_type, cost: 5 }
  let(:user) { FactoryBot.create :user }

  before do
    sign_in user
  end

  describe 'POST #create' do
    subject { post :create, params: { dragons_team: { name: 'Name', level: 0, dragon_type_id: dragon_type.id, description: 'test' } } }
    it do
      expect { subject }.to change { user.dragons.reload.size }.by(1)
      # subject
      # print user.dragons.last.dragon_type.name
    end

    context 'with dragons limit' do
      let(:dragon) { FactoryBot.create :dragon, user: user, dragon_type: dragon_type }
      let(:dragon1) { FactoryBot.create :dragon, user: user, dragon_type: dragon_type }
      let(:dragon2) { FactoryBot.create :dragon, user: user, dragon_type: dragon_type }
      let(:dragon3) { FactoryBot.create :dragon, user: user, dragon_type: dragon_type }
      let(:dragon4) { FactoryBot.create :dragon, user: user, dragon_type: dragon_type }
      it do
        dragon.save
        dragon1.save
        dragon2.save
        dragon3.save
        dragon4.save
        user.reload
        expect { subject }.to change { user.dragons.reload.size }.by(0)
        expect(flash[:alert]).to eq("You can't add more dragons")
      end
    end
  end
end
