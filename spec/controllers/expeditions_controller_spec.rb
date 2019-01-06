require 'rails_helper'

RSpec.describe ExpeditionsController, type: :controller do
  let!(:user) { FactoryBot.create :user }
  let!(:dragon_type) { FactoryBot.create :dragon_type }
  let!(:dragon) { FactoryBot.create :dragon, user: user, level: 0 }
  let!(:attributes_type) { FactoryBot.create :attributes_type }
  let!(:expedition_type) { FactoryBot.create :expedition_type }
  let!(:perception_type) { FactoryBot.create :attributes_type, name: 'Perception' }
  let!(:luck_type) { FactoryBot.create :attributes_type, name: 'Luck' }
  let!(:strength_type) { FactoryBot.create :attributes_type, name: 'Strength' }

  before do
    sign_in user
  end

  describe 'POST #create' do
    subject { post :create, params: { expedition: { dragon_id: dragon.id, expedition_type_id: expedition_type.id, start_time: Time.now } } }
    it do
      expect { subject }.to change { Expedition.all.size }.by(1)
      expect(flash[:notice]).to eq('You sent Expedition!')
    end
  end
end
