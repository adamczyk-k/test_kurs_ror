require 'rails_helper'

RSpec.describe DragonsProvider do
  let(:user) { FactoryBot.create :user }
  let(:dragon_type1) { FactoryBot.create :dragon_type }

  before do
    sign_in user
  end

  describe '#results' do
    subject { described_class.new(key).results }

    context 'with lowercase key' do
      let!(:dragon1) { FactoryBot.create :dragon, user: user, name: 'Dragon 1', dragon_type: dragon_type1 }
      let(:key) { 'dra' }

      it { is_expected.to include(dragon1) }
    end
  end
end