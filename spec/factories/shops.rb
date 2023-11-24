FactoryBot.define do
  
  factory :shop do
  	association :user, factory: :user
  	association :item, factory: :item
  end
end
