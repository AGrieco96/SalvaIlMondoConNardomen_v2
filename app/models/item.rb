class Item < ApplicationRecord
	enum category: [ :skin, :enemy, :sword, :landscape ]
	validates :name, presence: true, uniqueness: true
	validates :level, presence: true
	validates :price, presence:true
	validates :category, presence:true

	validate :category_range

	# order
  default_scope -> { order(:level) }

	#shops model
	has_many :shops

	def category_range
		if !(category.nil? || skin? || enemy? || sword? || landscape?)
			errors.add(:category, 'Out of Range Type.')
		end
	end

	# Retrieve skins
	def self.skins
		self.where(category: 0)
	end

	# Retrieve enemies
	def self.enemies
		self.where(category: 1)
	end

	# Retrieve swords
	def self.swords
		self.where(category: 2)
	end

	# Retrieve landscapes
	def self.landscapes
		self.where(category: 3)
	end

	# Retrive default skin
	def self.default_skin
		self.find_by(name: 'skin1')  
	end

	# Retrive default enemy
	def self.default_enemy
		self.find_by(name: 'enemy1')  
	end

	# Retrive default sword
	def self.default_sword
		self.find_by(name: 'sword1')  
	end

	# Retrive default lanscape
	def self.default_landscape
		self.find_by(name: 'landscape1')  
	end

end
