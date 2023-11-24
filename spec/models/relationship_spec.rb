require 'rails_helper'
require 'spec_helper'
require 'factory_bot_rails'

RSpec.describe Relationship, type: :model do
  
	it "has valid fatory" do
		expect(FactoryBot.create(:relationship)).to be_valid
	end

	it "is not valid without follower_id" do
		expect(FactoryBot.build(:relationship, follower_id: nil)).to_not be_valid
	end

	it "is not valid withput followed_id" do
		expect(FactoryBot.build(:relationship, followed_id: nil)).to_not be_valid
	end

end
