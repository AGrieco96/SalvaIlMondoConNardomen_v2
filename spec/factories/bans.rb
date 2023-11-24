require 'faker'

FactoryBot.define do
  
	factory :ban_temp, class: Ban do
  	association :user, factory: :user
  	request { false }
  	day_ban { Random.rand(10).days.from_now }
  end

  factory :ban_perm, class: Ban do
  	association :user, factory: :user
  	request { false }
  	day_ban { DateTime.now..DateTime::Infinity.new }
  end

  factory :ban_req, class: Ban do
  	association :user, factory: :user
  	request { true }
  	day_ban { nil }
  end

end
