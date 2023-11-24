class Notification < ApplicationRecord
	enum category: [ :score , :follower]
	validates :actor_id, presence: :true
	validates :dest_id, presence: :true
	validates :category, presence: :true

	validate :score_presence

	belongs_to :actor, class_name: 'User'
	belongs_to :dest, class_name: 'User'

	scope :unread, -> { where(read_at: nil) }
	default_scope -> { order(created_at: :desc) }

	def score_presence
		if (category == 'score' && new_best_score.nil?) || (category == 'follower' && !new_best_score.nil?)
			errors.add(:category, 'Notification instance invalid.')
		end
	end

end
