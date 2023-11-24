require 'rails_helper'

RSpec.describe Notification, type: :model do

	it 'has valid factory' do
		expect(FactoryBot.create(:notification)).to be_valid
	end

	it 'has valid new best score notification factory' do
		expect(FactoryBot.create(:score_notif)).to be_valid
	end

	it 'has valid new follower notification factory' do
		expect(FactoryBot.create(:follower_notif)).to be_valid
	end

	it 'is invalid without actor_id' do
		expect(FactoryBot.build(:notification, actor_id: nil)).to_not be_valid
	end

	it 'is invalid without dest_id' do
		expect(FactoryBot.build(:notification, dest_id: nil)).to_not be_valid
	end

	it 'is invalid without category' do
		expect(FactoryBot.build(:notification, category: nil)).to_not be_valid
	end 

	it 'the new score notification is invalid without new_best_score' do
		expect(FactoryBot.build(:score_notif, new_best_score: nil)).to_not be_valid
	end

	it 'the new follower notification is valid without new_best_score' do
		expect(FactoryBot.build(:follower_notif, new_best_score:nil)).to be_valid
	end

	it ' has created_at desc order' do
  	user = FactoryBot.create(:user)
  	FactoryBot.create_list(:notification, 10, dest: user)
  	expect(user.scores.first).to eq user.scores.max_by(&:created_at)
  end

end
