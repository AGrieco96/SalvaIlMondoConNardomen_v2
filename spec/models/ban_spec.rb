require 'rails_helper'

@ban		=		nil

RSpec.describe Ban, type: :model do
  
	it 'temporany ban has valid factory' do
		expect(FactoryBot.create(:ban_temp)).to be_valid
	end

	it 'permanent ban has valid factory' do
		expect(FactoryBot.create(:ban_perm)).to be_valid
	end

	it "permanent ban request has valid factory" do
		expect(FactoryBot.create(:ban_req)).to be_valid
	end

	it 'temporany ban is invalid without user' do
		expect(FactoryBot.build(:ban_temp, user: nil)).to_not be_valid
	end

	it 'permanent ban is invalid without user' do
		expect(FactoryBot.build(:ban_perm, user: nil)).to_not be_valid
	end

	it 'permanent ban request is invalid without user' do
		expect(FactoryBot.build(:ban_req, user: nil)).to_not be_valid
	end

	it 'is invalid with same user' do
		@ban 	= FactoryBot.create(:ban_temp)
		expect(FactoryBot.build(:ban_temp, user: @ban.user)).to_not be_valid
		@ban 	= FactoryBot.create(:ban_perm)
		expect(FactoryBot.build(:ban_perm, user: @ban.user)).to_not be_valid
		@ban 	= FactoryBot.create(:ban_req)
		expect(FactoryBot.build(:ban_req, user: @ban.user)).to_not be_valid
	end

end
