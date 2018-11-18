require 'rails_helper'

RSpec.describe AddDragon do
  describe '#pay_for_dragon' do

    context 'free dragon' do
      let!(:dragon_type) { FactoryBot.create :dragon_type }
      let!(:user) { FactoryBot.create :user }
      let!(:dragon) { FactoryBot.create :dragon, dragon_type: dragon_type }

      it 'free dragon' do
        AddDragon.run!(user: user, dragon: dragon)
        expect(user.dragons.last.dragon_type).to eq(dragon_type)
      end
    end


  end
end