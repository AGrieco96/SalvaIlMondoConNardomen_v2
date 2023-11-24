require 'faker'

FactoryBot.define do

  factory :item do
    name {Faker::Name.first_name}
    category {Random.rand(4)}
    level {Random.rand(20)}
    price {50+Random.rand(150)}
  end

  factory :skin, class: Item do
  	name {Faker::Name.first_name}
    category {0}
    level {Random.rand(20)}
    price {50+Random.rand(150)}
  end

  factory :enemy, class: Item do
  	name {Faker::Name.first_name}
    category {1}
    level {Random.rand(20)}
    price {50+Random.rand(150)}
  end

  factory :sword, class: Item do
  	name {Faker::Name.first_name}
    category {2}
    level {Random.rand(20)}
    price {50+Random.rand(150)}
  end

  factory :landscape, class: Item do
  	name {Faker::Name.first_name}
    category {3}
    level {Random.rand(20)}
    price {50+Random.rand(150)}
  end

  factory :default_skin, class: Item do
  	name {'skin1'}
    category {0}
    level {0}
    price {0}
  end

  factory :default_enemy, class: Item do
  	name {'enemy1'}
    category {0}
    level {0}
    price {0}
  end

  factory :default_sword, class: Item do
  	name {'sword1'}
    category {0}
    level {0}
    price {0}
  end

  factory :default_landscape, class: Item do
  	name {'landscape1'}
    category {0}
    level {0}
    price {0}
  end


end
