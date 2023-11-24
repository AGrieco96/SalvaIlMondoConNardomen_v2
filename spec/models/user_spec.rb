require 'rails_helper'
require 'spec_helper'
require 'factory_bot_rails'

RSpec.describe User, type: :model do

  it "has valid factory" do
  	expect(FactoryBot.create(:user)).to be_valid
  end

  it 'has valid complete_user factory' do
  	expect(FactoryBot.create(:complete_user)).to be_valid
  end

  it 'has valid game master factory' do
  	expect(FactoryBot.create(:game_master)).to be_valid
  end

  it 'has valid game founder factory' do
  	expect(FactoryBot.create(:game_founder)).to be_valid
  end

  it 'has valid user_with_items factory' do
  	expect(FactoryBot.create(:user_with_items)).to be_valid
  end

  it "is invalid without name" do
  	expect(FactoryBot.build(:user, name: nil)).to_not be_valid
  end

  it "is invalid without last name" do 
  	expect(FactoryBot.build(:user , last_name: nil)).to_not be_valid
  end

  it "is invalid without email" do 
  	expect(FactoryBot.build(:user , email: nil)).to_not be_valid
  end

  it "is invalid without password" do 
  	expect(FactoryBot.build(:user , password: nil)).to_not be_valid
  end

  it "is invalid without nickname" do 
  	expect(FactoryBot.build(:user , nickname: nil)).to_not be_valid
  end

  it "is invalid with the same other user's email" do
  	user = FactoryBot.create(:user)
  	expect(FactoryBot.build(:user, email: user.email)).to_not be_valid
  end

	it "is invalid with the same other user's nickname" do
  	user = FactoryBot.create(:user)
  	expect(FactoryBot.build(:user, nickname: user.nickname)).to_not be_valid
  end

  it "can follow and unfollow other users" do
  	user1 = FactoryBot.create(:user)
  	user2 = FactoryBot.create(:user)
  	expect(user1.following?(user2)).to be false
  	user1.follow(user2)
  	expect(user1.following?(user2)).to be true
  	expect(user2.followers.include?(user1)).to be true
  	user1.unfollow(user2)
  	expect(user1.following?(user2)).to be false
  end


end
