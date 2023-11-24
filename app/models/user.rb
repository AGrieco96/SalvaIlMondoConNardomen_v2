class User < ApplicationRecord
	mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter]  
  validates :name, presence: true
  validates :last_name, presence: true
  validates :nickname, presence: true
  validates :nickname, uniqueness: true, if: -> {self.nickname.present?}

  # Relationship model
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy

  has_many :following, through: :active_relationships, source: :followed

	has_many :passive_relationships, class_name:  "Relationship",
                                 foreign_key: "followed_id",
                                 dependent:   :destroy

  has_many :followers, through: :passive_relationships

  # Game Data model
  has_one :game_datum, dependent:   :destroy

  # Score model
  has_many :scores, dependent:   :destroy

  # Shop model
  has_many :shops, dependent:   :destroy

  has_many :items, through: :shops, dependent:   :destroy

  # Notifications model
  has_many :notifications, foreign_key: :dest_id

  # Profile image
  validates_integrity_of  :avatar
  
  validates_processing_of :avatar

  # Follows a user.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  # Search tools
  def self.search(search)
  	where("nickname LIKE ? ", "%#{search}%") 
	end

	# Omniauth login/sign up Facebook/Twitter
	def self.create_from_facebook_omniauth(params)
		user = User.find_by(email: params.info.email)
		user = User.find_by(uid: params.uid) if user.nil?
		if user.nil?
			pass = 'NardomenFriendlyPassword'
			user = User.create!( name: params.info.first_name,
														last_name: params.info.last_name,
														nickname: 'Guest'+Random.rand(100000).to_s,
														email: params.info.email,
														password: pass,
														password_confirmation: pass)
			user.set_default_data
		end
    user.update({
      token: params.credentials.token,
      provider: params.provider,
      uid: params.uid
    }) 
    user
  end

  def self.create_from_twitter_omniauth(params)
		user = User.find_by(email: params.info.email)
		user = User.find_by(uid: params.uid) if user.nil?
		if user.nil?
			pass = 'NardomenFriendlyPassword'
			complete_name = params.info.name
			name = complete_name.split
			user = User.create!( name: name[0],
														last_name: name[1],
														nickname: 'Guest'+Random.rand(100000).to_s,
														email: params.info.email,
														password: pass,
														password_confirmation: pass)
			user.set_default_data
		end
    user.update({
      token: params.credentials.token,
      provider: params.provider,
      uid: params.uid
    }) 
    user
  end

	# Returns a user's status feed.
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Score.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  # Return user's level
  def level
  	game_datum.level
  end

  # Return user's money
  def money
  	game_datum.money
  end

  def exp
  	game_datum.exp
  end

  # Return user's best score
  def best_score
  	scores.max_by(&:score).score
  end

  # Returns first 5 notifications
  def notif
  	notifications.first(5)
  end

  # Has item?
  def has_item?(item)
  	items.include?(item)
  end

  # user can buy item?
  def can_buy?(item)
  	level >= item.level && money >= item.price
  end

  # Return active skin
  def skin
  	game_datum.skin
  end

  # Return active enemy
  def enemy
  	game_datum.enemy
  end

  # Return active sword
  def sword
  	game_datum.sword
  end

  # Return active landscape
  def landscape
  	game_datum.landscape
  end

  # Return purchased skins
  def skins
  	items.where(category: "skin")
  end

  # Return purchased enemies
  def enemies
  	items.where(category: "enemy")
  end

  # Return purchased swords
  def swords
  	items.where(category: "sword")
  end

  # Return purchased landscapes
  def landscapes
  	items.where(category: "landscape")
  end

  # Change active skin
  def change_skin(new_skin)
  	game_datum.update_attribute(:skin, new_skin)
  end

  # Change active skin
  def change_enemy(new_enemy)
  	game_datum.update_attribute(:enemy, new_enemy)
  end

  # Change active skin
  def change_sword(new_sword)
  	game_datum.update_attribute(:sword, new_sword)
  end

  # Change active skin
  def change_landscape(new_landscape)
  	game_datum.update_attribute(:landscape, new_landscape)
  end

  # Set default items and data at sign up
  def set_default_data
  	skin = Item.default_skin
    enemy = Item.default_enemy
    sword = Item.default_sword
    landscape = Item.default_landscape
    create_game_datum(money: 50, level: 1, exp: 0, skin: skin, enemy: enemy, sword: sword, landscape: landscape ) 
    items << skin
    items << enemy
    items << sword
    items << landscape
    update({
      token: nil,
      provider: nil,
      uid: nil
    	}) 
	end


	# destroy items and data when user cancel the account
	def destroy_user
		user_shops = shops
  	user_scores = scores
  	user_shops.each do |shop|
  		shop.destroy
  	end
  	user_scores.each do |score|
  		score.destroy
  	end
  	game_datum.destroy
	end
	
	# Private functions
	private
  
    def avatar_size_validation
      errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
    end

end
