require 'rails_helper'

RSpec.describe Shop, type: :model do

  it 'has valid factory' do
  	price = Random.rand(100)
  	level = Random.rand(10)
  	user = FactoryBot.create(:user)
  	data = FactoryBot.create(:game_datum, user: user, money: price+Random.rand(100), level: level+Random.rand(5))
  	item = FactoryBot.create(:item, price: price, level: level)
  	expect(FactoryBot.create(:shop, user: user, item: item)).to be_valid
  end

  it 'is invalid without user_id' do
  	expect(FactoryBot.build(:shop, user: nil)).to_not be_valid
  end

  it 'is invalid without item_id' do
  	expect(FactoryBot.build(:shop, item: nil)).to_not be_valid
  end

  it 'is not valid if user money < item price' do
  	user = FactoryBot.create(:user)
  	user.create_game_datum(money: Random.rand(50), level:5+Random.rand(5))
  	item = FactoryBot.create(:item)
  	item.price = 50+Random.rand(100)
  	item.level = Random.rand(5)
  	expect(FactoryBot.build(:shop, item: item, user: user)).to_not be_valid
  end

end
