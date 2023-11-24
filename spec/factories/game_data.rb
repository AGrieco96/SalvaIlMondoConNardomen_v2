require 'factory_bot_rails'
require 'faker'

FactoryBot.define do
  factory :game_datum do
    association :user, factory: :user
    money {50+Random.rand(100)}
    level {1+Random.rand(10)}
    exp { 100+Random.rand(5000) }
    association :skin , factory: :skin
    association :enemy , factory: :enemy
    association :sword , factory: :sword
    association :landscape , factory: :landscape
  end
end
