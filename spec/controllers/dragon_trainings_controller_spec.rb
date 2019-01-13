require 'rails_helper'

RSpec.describe DragonTrainingsController do
  let(:dragon_type) { FactoryBot.create :dragon_type }
  let(:dragon) { FactoryBot.create :dragon }
  let(:training) { FactoryBot.create :training }
  let(:user) { FactoryBot.create :user }

  before do
    sign_in user
  end

  describe 'POST #create' do
    subject { post :create, params: { dragon_trainings: { dragon_id: dragon.id }, format: training } }
    it do
      expect { subject }.to change { DragonTraining.all.size }.by(1)
    end

    context 'with dragon is training right now' do
      let!(:dragon_training) { FactoryBot.create :dragon_training, training: training, dragon: dragon }
      it do
        expect { subject }.to change { DragonTraining.all.size }.by(0)
        expect(flash[:alert]).to eq("#{dragon.name} is already on training, choose another dragon")
      end
    end

    context 'with lacking resources' do
      let!(:resource_type) { FactoryBot.create :resource_type }
      let!(:training_cost) { FactoryBot.create :training_cost, training: training, resource_type: resource_type, cost: 1 }
      it do
        expect { subject }.to change { DragonTraining.all.size }.by(0)
        expect(flash[:alert]).to eq("Lacking resources: #{training_cost.cost} #{training_cost.resource_type.name} ")
      end
    end
  end
end
