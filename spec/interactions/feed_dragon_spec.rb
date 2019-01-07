require 'rails_helper'

RSpec.describe FeedDragon do
  describe '#can_dragon_eat?' do
    let!(:dragon) { FactoryBot.create :dragon, level: 0 }
    let!(:attributes_type) { FactoryBot.create :attributes_type }

    context "When dragon didn't eat" do
      it 'Dragon will level up' do
        FeedDragon.run!(dragon: dragon, attributes_type: attributes_type)
        expect(dragon.dragon_attribute.last.level).to eq(1)
        expect(dragon.level).to eq(1)
      end
    end

    context 'When dragon cannot eat' do
      it 'Dragon will not level up' do
        FeedDragon.run!(dragon: dragon, attributes_type: attributes_type)
        FeedDragon.run!(dragon: dragon, attributes_type: attributes_type)
        expect(dragon.dragon_attribute.last.level).to eq(1)
        expect(dragon.level).to eq(1)
      end
    end

    context 'When dragon eat long time ago' do
      it 'Dragon will level up' do
        FeedDragon.run!(dragon: dragon, attributes_type: attributes_type)
        last_food = FoodTime.last
        last_food.update_attribute(:time, Time.now - 2.days)
        FeedDragon.run!(dragon: dragon, attributes_type: attributes_type)
        expect(dragon.dragon_attribute.last.level).to eq(2)
        expect(dragon.level).to eq(2)
      end
    end
  end
end
