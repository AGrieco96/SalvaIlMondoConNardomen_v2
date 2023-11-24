class Relationship < ApplicationRecord
	after_create :create_notifications
	belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, presence: true
  validates :followed_id, presence: true

  private

  	def create_notifications
  		Notification.create( actor: follower , dest: followed , category: 'follower')
  	end
  
end
