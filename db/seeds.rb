# Items
Item.create!(	name: 'sword1',
							category: 2,
							level: 0,
							price: 0)

Item.create!(	name: 'skin1',
							category: 0,
							level: 0,
							price: 0)

Item.create!(	name: 'enemy1',
							category: 1,
							level: 0,
							price: 0)

Item.create!(	name: 'landscape1',
							category: 3,
							level: 0,
							price: 0)

Item.create!(	name: 'sword2',
							category: 2,
							level: 3,
							price: 50)

Item.create!(	name: 'skin2',
							category: 0,
							level: 3,
							price: 80)

Item.create!(	name: 'enemy2',
							category: 1,
							level: 3,
							price: 30)

Item.create!(	name: 'landscape2',
							category: 3,
							level: 3,
							price: 100)

Item.create!(	name: 'sword3',
							category: 2,
							level: 7,
							price: 114)

Item.create!(	name: 'skin3',
							category: 0,
							level: 7,
							price: 145)

Item.create!(	name: 'enemy3',
							category: 1,
							level: 7,
							price: 76)

Item.create!(	name: 'landscape3',
							category: 3,
							level: 7,
							price: 270)

Item.create!(	name: 'GodSword',
							category: 2,
							level: 100,
							price: 10000)

skin = Item.find_by(name: 'skin1')
enemy = Item.find_by(name: 'enemy1')
sword = Item.find_by(name: 'sword1')
landscape = Item.find_by(name: 'landscape1')

#CREAZIONE DEI 3 ACCOUNT PRINCIPALI
if ENV['RAILS_ENV'] == 'production'
	user = User.create!( name: "Stefano",
											last_name: "Milani",
											nickname: "Rahios",
											email: "stefano.milani96@gmail.com",
											password: "ciaociao",
											password_confirmation: "ciaociao", 
											provider: '',
											uid: '',
											token: '',
											gf: true,
											gm: false)
	
	user.set_default_data

	user = User.create!( name: "Andrea",
											last_name: "Nardocci",
											nickname: "Nardoz",
											email: "nardomen96@gmail.com",
											password: "ciaociao",
											password_confirmation: "ciaociao", 
											provider: '',
											uid: '',
											token: '',
											gf: true,
											gm: false)
	
	user.set_default_data

	user = User.create!( name: "Antonio",
											last_name: "Grieco",
											nickname: "Blackf1re",
											email: "antonio_grieco.96@hotmail.it",
											password: "ciaociao",
											password_confirmation: "ciaociao", 
											provider: '',
											uid: '',
											token: '',
											gf: true,
											gm: false)
	
	user.set_default_data


else
	# GameAdmin
	user = User.create!( name: "Stefano",
											last_name: "Milani",
											nickname: "Rahios",
											email: "stefano_fsdnitt_milani@tfbnw.net",
											password: "ciaociao",
											password_confirmation: "ciaociao", 
											provider: 'facebook',
											uid: '100028640361870',
											token: '',
											gf: false,
											gm: true)

	user.create_game_datum(money: 600, level: 20, skin: skin, exp: 0, enemy: enemy, sword: sword, landscape: landscape)
	user.items << skin
	user.items << enemy
	user.items << sword
	user.items << landscape
	50.times do |n|
		user.scores.create(score: Random.rand(1000))
	end


	# GameFounder
	user = User.create!( name: "Andrea", last_name:"N", nickname:"nardoz0918",
						 email:"andrea_ciao@ciaociao.it", password:"ciaociao",
						 password_confirmation:"ciaociao",
						 provider:'facebook',uid:'',token:'',
						 gf:true, gm:false)

	user.create_game_datum(money: 1000000, level: 40, skin: skin, exp: 0, enemy: enemy, sword: sword, landscape: landscape)
	user.items << skin
	user.items << enemy
	user.items << sword
	user.items << landscape
	user = User.create!( name: "Susan",
											last_name: "Letuchyman",
											nickname: "Albhffaggijbi",
											email: "neeocnrkvo_1537531034@tfbnw.net",
											password: "ciaociao",
											password_confirmation: "ciaociao", 
											provider: 'facebook',
											uid: '113075936324465',gf: false,
											gm: false)

	user.create_game_datum(money: 600, level: 20, exp: 0, skin: skin, enemy: enemy, sword: sword, landscape: landscape)
	user.items << skin
	user.items << enemy
	user.items << sword
	user.items << landscape
	50.times do |n|
		user.scores.create(score: Random.rand(1000))
	end

	user = User.create!( name: "Helen",
											last_name: "Narayananwitz",
											nickname: "Albhfegjciae",
											email: "gfbsjakzyn_1537531028@tfbnw.net",
											password: "ciaociao",
											password_confirmation: "ciaociao", 
											provider: 'facebook',
											uid: '114439846187916',
											gf: false,
											gm: false)

	user.create_game_datum(money: 600, level: 20, exp: 0, skin: skin, enemy: enemy, sword: sword, landscape: landscape)
	user.items << skin
	user.items << enemy
	user.items << sword
	user.items << landscape
	50.times do |n|
		user.scores.create(score: Random.rand(1000))
	end

	49.times do |n|
		user = FactoryBot.create(:user)
		user.create_game_datum(money: 50+Random.rand(100), level: Random.rand(10), exp: 0, skin: skin, enemy: enemy, sword: sword, landscape: landscape)
		50.times do |n|
			user.scores.create(score: Random.rand(1000))
		end
		user.items << skin
		user.items << enemy
		user.items << sword
		user.items << landscape
	end

	# Following relationships
	users = User.all
	user  = users.first
	following = users[2..50]
	followers = users[3..40]
	following.each { |followed| user.follow(followed) }
	followers.each { |follower| follower.follow(user) }

	following.first(3).each do |user|
		user.scores.create(score: 1000+Random.rand(100))
	end


end

