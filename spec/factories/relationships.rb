require 'factory_bot_rails'
require 'faker'

FactoryBot.define do

  factory :relationship do |f|
  	association :follower, factory: :user
    association :followed, factory: :user
  end

end
