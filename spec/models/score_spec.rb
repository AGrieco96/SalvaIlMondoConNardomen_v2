require 'rails_helper'

RSpec.describe Score, type: :model do
  
  it 'has valid factory' do
  	expect(FactoryBot.create(:score)).to be_valid
  end

  it 'is invalid without user_id' do
  	expect(FactoryBot.build(:score, user: nil)).to_not be_valid
  end

  it 'is invalid without score' do
  	expect(FactoryBot.build(:score, score:nil)).to_not be_valid
  end

  it ' has created_at desc order' do
  	user = FactoryBot.create(:user)
  	FactoryBot.create_list(:score, 10, user: user)
  	expect(user.scores.first).to eq user.scores.max_by(&:created_at)
  end

end
