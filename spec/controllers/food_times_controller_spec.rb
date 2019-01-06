require 'rails_helper'

RSpec.describe FoodTimesController, type: :controller do
  let!(:user) { FactoryBot.create :user }
  let!(:dragon_type) { FactoryBot.create :dragon_type }
  let!(:dragon) { FactoryBot.create :dragon, user: user, level: 0 }
  let!(:attributes_type) { FactoryBot.create :attributes_type }

  before do
    sign_in user
  end

  describe 'POST #create' do
    subject { post :create, params: { food_time: { dragon: dragon, attributes_type_id: attributes_type } } }
    it do
      dragon_attributes = DragonAttribute.where(dragon: dragon)
      expect { subject }.to change { dragon_attributes.size }.by(1)
      expect(flash[:alert]).to eq("You level up #{dragon.name}'s #{dragon_attributes.last.attributes_type.name} to #{dragon_attributes.last.level}. Your dragon levels up by 1 level")
    end

    context 'when you could not feed dragon' do
      let!(:food_time) { FactoryBot.create :food_time, dragon: dragon, time: Time.now }
      it do
        dragon_attributes = DragonAttribute.where(dragon: dragon)
        expect { subject }.to change { dragon_attributes.size }.by(0)
        expect(flash[:alert]).to eq("You already fed #{dragon.name}")
      end
    end
  end
end
