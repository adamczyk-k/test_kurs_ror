require 'rails_helper'

RSpec.describe DragonsProvider do
  let(:user) { FactoryBot.create :user }
  let(:dragon_type1) { FactoryBot.create :dragon_type }

  describe '#results' do
    subject { described_class.new(current_user, key).results }

    context 'with lowercase key' do
      let!(:dragon1) { FactoryBot.create :dragon, user: user, name: 'Dragon 1', dragon_type: dragon_type1 }
      let(:key) { 'dragon 1' }
      let(:current_user) { user }

      it { is_expected.to include(dragon1) }
    end

    context 'with prefix' do
      let!(:dragon1) { FactoryBot.create :dragon, user: user, name: 'Dragon 1', dragon_type: dragon_type1 }
      let(:key) { 'dra' }
      let(:current_user) { user }

      it { is_expected.to include(dragon1) }
    end

    context 'with reverse words' do
      let!(:dragon2) { FactoryBot.create :dragon, user: user, name: 'Dragon name', dragon_type: dragon_type1 }
      let(:key) { 'name dragon' }
      let!(:current_user) { user }

      it { is_expected.to include(dragon2) }
    end
  end
end
