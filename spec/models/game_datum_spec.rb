require 'rails_helper'
require 'factory_bot_rails'

RSpec.describe GameDatum, type: :model do
  
  it 'has valid factory' do
  	expect(FactoryBot.create(:game_datum)).to be_valid
	end

	it 'is not valid with same user_id' do
		data = FactoryBot.create(:game_datum)
		expect(FactoryBot.build(:game_datum, user_id: data.user_id)).to_not be_valid
	end

	it 'is not valid without user_id' do
		expect(FactoryBot.build(:game_datum, user_id: nil)).to_not be_valid
	end

	it 'is not valid without level' do
		expect(FactoryBot.build(:game_datum, level: nil)).to_not be_valid
	end

	it 'is not valid without money' do
		expect(FactoryBot.build(:game_datum, money: nil)).to_not be_valid
	end

	it 'is not valid without exp' do
		expect(FactoryBot.build(:game_datum, exp: nil)).to_not be_valid
	end

	it 'is invalid with wrong skin item' do
		sword = FactoryBot.build(:sword)
		expect(FactoryBot.build(:game_datum, skin: sword)).to_not be_valid
		enemy = FactoryBot.build(:enemy)
		expect(FactoryBot.build(:game_datum, skin: enemy)).to_not be_valid
		landscape = FactoryBot.build(:landscape)
		expect(FactoryBot.build(:game_datum, skin: landscape)).to_not be_valid
	end

	it 'is invalid with wrong enemy item' do
		sword = FactoryBot.build(:sword)
		expect(FactoryBot.build(:game_datum, skin: sword)).to_not be_valid
		skin = FactoryBot.build(:skin)
		expect(FactoryBot.build(:game_datum, skin: skin)).to_not be_valid
		landscape = FactoryBot.build(:landscape)
		expect(FactoryBot.build(:game_datum, skin: landscape)).to_not be_valid
	end

	it 'is invalid with wrong sword item' do
		skin = FactoryBot.build(:skin)
		expect(FactoryBot.build(:game_datum, skin: skin)).to_not be_valid
		enemy = FactoryBot.build(:enemy)
		expect(FactoryBot.build(:game_datum, skin: enemy)).to_not be_valid
		landscape = FactoryBot.build(:landscape)
		expect(FactoryBot.build(:game_datum, skin: landscape)).to_not be_valid
	end

	it 'is invalid with wrong landscape item' do
		sword = FactoryBot.build(:sword)
		expect(FactoryBot.build(:game_datum, skin: sword)).to_not be_valid
		enemy = FactoryBot.build(:enemy)
		expect(FactoryBot.build(:game_datum, skin: enemy)).to_not be_valid
		skin = FactoryBot.build(:skin)
		expect(FactoryBot.build(:game_datum, skin: skin)).to_not be_valid
	end

end
