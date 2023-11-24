class Score < ApplicationRecord
	after_create :create_notifications
  belongs_to :user
  # validates
  validates :user_id, presence: true
  validates :score, presence: true
  # order
  default_scope -> { order(created_at: :desc) }

  
  private

  	def best_scores
  		user.scores.order(:score).first(2)
  	end

  	def create_notifications
  		if best_scores[1].nil? || best_scores[1].score < score
  			user.followers.each do |follower|
  				Notification.create( actor: user, dest: follower, category: 'score', new_best_score: score )
  			end
  		end
  	end


end
