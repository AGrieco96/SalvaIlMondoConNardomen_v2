class Ban < ApplicationRecord
	belongs_to :user

	validates :user_id, presence:true
	validates :user_id, uniqueness: true
	validate :control_ban


	def control_ban
		(request && day_ban.nil?) || (!request && !day_ban.nil?)
	end
	
end
