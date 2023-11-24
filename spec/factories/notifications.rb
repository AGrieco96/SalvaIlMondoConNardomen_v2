FactoryBot.define do
  # General Notification
  factory :notification do
    association :actor, factory: :user 
    association :dest, factory: :user 
    category { Random.rand(1) }
    new_best_score { 1 }
    read_at { nil }
  end
  # New best score notification
  factory :score_notif, class: Notification do 
  	association :actor, factory: :user 
    association :dest, factory: :user 
    category { 'score' }
    new_best_score { 500+Random.rand(500) }
    read_at { nil }
  end
  # New follower notification
  factory :follower_notif, class: Notification do
  	association :actor, factory: :user 
    association :dest, factory: :user 
    category { 'follower' }
    new_best_score { nil }
    read_at { nil }
  end
end
