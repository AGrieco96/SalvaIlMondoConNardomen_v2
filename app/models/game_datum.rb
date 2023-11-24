class GameDatum < ApplicationRecord
	belongs_to :user
	belongs_to :skin, class_name: 'Item'
	belongs_to :enemy, class_name: 'Item'
	belongs_to :sword, class_name: 'Item'
	belongs_to :landscape, class_name: 'Item'

	validates :user_id, presence: true 
	validates :user_id, uniqueness: true
	validates :level, presence: true
	validates :money, presence: true
	validates :exp, presence: :true
	validates :skin_id, presence: true
	validates :enemy_id, presence: true
	validates :sword_id, presence: true
	validates :landscape_id, presence: true

	validate :is_skin
	validate :is_enemy
	validate :is_sword
	validate :is_landscape

	def is_skin
		skin.skin? unless(skin.nil?)
	end

	def is_enemy
		enemy.enemy? unless(enemy.nil?)
	end

	def is_sword
		sword.sword? unless(sword.nil?)
	end

	def is_landscape
		landscape.landscape? unless(landscape.nil?)
	end

end
