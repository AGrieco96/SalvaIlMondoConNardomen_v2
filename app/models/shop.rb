class Shop < ApplicationRecord
  belongs_to :user
  belongs_to :item

  # validates
  validates_uniqueness_of :user_id, :scope => [:item_id]
  validates :user_id, presence: true
  validates :item_id, presence: true
  validate :check_level
  validate :check_money

  def check_level 
  	if !(item.nil? || user.nil?) && item.level > user.game_datum.level
  		errors.add(:user, 'You must be at level #{item.level} or up')
  	end
  end

  def check_money 
  	if !(item.nil? || user.nil?) && item.price > user.game_datum.money
  		errors.add(:user, 'You must have at least #{item.money}')
  	end
  end

end
