FactoryBot.define do
	require 'faker'

  factory :user do |f|
  	f.name { Faker::Name.first_name }
    f.last_name { Faker::Name.last_name }
    f.email {Faker::Internet.email}
    f.nickname {Faker::Internet.user_name}
    f.password {Faker::Internet.password}

    factory :complete_user do
    	transient do
    		skin 				{	if Item.default_skin.nil? 
    										FactoryBot.create(:default_skin) 
    									else 
    										Item.default_skin 
    									end }
    		enemy 			{	if Item.default_enemy.nil? 
    										FactoryBot.create(:default_enemy) 
    									else 
    										Item.default_enemy 
    									end }
				sword 			{	if Item.default_sword.nil? 
    										FactoryBot.create(:default_sword) 
    									else 
    										Item.default_sword 
    									end }
				landscape 	{	if Item.default_landscape.nil? 
    										FactoryBot.create(:default_landscape) 
    									else 
    										Item.default_landscape 
    									end }
    		level 			{ 1+Random.rand(9) }
    		money 			{ 50+Random.rand(100) }
    		exp 				{ 100+Random.rand(5000) }
			end
    	after(:create) do |user, evaluator|
    		user.create_game_datum(money: evaluator.money, level: evaluator.level, exp: evaluator.exp, skin: evaluator.skin, enemy: evaluator.enemy, sword: evaluator.sword, landscape: evaluator.landscape ) 
    		user.items << evaluator.skin
    		user.items << evaluator.enemy
    		user.items << evaluator.sword
    		user.items << evaluator.landscape
    	end

    	factory :game_master do
    		gm { true }
    	end

    	factory :game_founder do
    		gf { true }
    	end

    	factory :user_with_items do
    		transient do
    			skin2				{	 FactoryBot.create(:skin,name: 'skin2', level: 1, price: Random.rand(50)) }

    			enemy2			{	FactoryBot.create(:enemy,name: 'enemy2', level: 1, price: Random.rand(50)) }

    			sword2			{	FactoryBot.create(:sword,name: 'sword2', level: 1, price: Random.rand(50)) }

    			landscape2	{	FactoryBot.create(:landscape,name: 'landscape2', level: 1, price: Random.rand(50)) }
    		end
    		after(:create) do |user, evaluator|
    			user.items << evaluator.skin2
    			user.items << evaluator.enemy2
    			user.items << evaluator.sword2
    			user.items << evaluator.landscape2
    		end
    	end

    end

  end

end
