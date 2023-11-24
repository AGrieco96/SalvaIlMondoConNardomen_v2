require 'rails_helper'

RSpec.describe Item, type: :model do
  
  it 'has valid factory' do
  	expect(FactoryBot.create(:item)).to be_valid
  end

  it 'has valid skin factory' do
  	skin = FactoryBot.create(:skin)
  	expect(skin).to be_valid
  	expect(skin.category).to eq('skin')
  end

  it 'has valid enemy factory' do
  	enemy = FactoryBot.create(:enemy)
  	expect(enemy).to be_valid
  	expect(enemy.category).to eq('enemy')
  end

  it 'has valid sword factory' do
  	sword = FactoryBot.create(:sword)
  	expect(sword).to be_valid
  	expect(sword.category).to eq('sword')
  end

  it 'has valid landscape factory' do
  	landscape = FactoryBot.create(:landscape)
  	expect(landscape).to be_valid
  	expect(landscape.category).to eq('landscape')
  end

  it 'is invalid without name' do
  	expect(FactoryBot.build(:item, name: nil)).to_not be_valid
  end

  it 'is invalid without level' do
  	expect(FactoryBot.build(:item, level: nil)).to_not be_valid
  end

  it 'is invalid without price' do
  	expect(FactoryBot.build(:item, price: nil)).to_not be_valid
  end

  it 'is invalid without category' do
  	expect(FactoryBot.build(:item, category: nil)).to_not be_valid
  end

  it 'is invalid with same name as a previous item' do
  	item = FactoryBot.create(:item)
  	expect(FactoryBot.build(:item, name: item.name)).to_not be_valid
  end

  # it 'is invalid with category > 3' do
  # 	expect(FactoryBot.build(:item, category: 4+Random.rand(10))).to_not be_valid
  # end

end
