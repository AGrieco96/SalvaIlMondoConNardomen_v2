FactoryBot.define do

  factory :score do |f|
  	association :user, factory: :user
  	f.score {Random.rand(1000)}
  end

end
