require 'faker'

FactoryBot.use_parent_strategy = false

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    name { Faker::Name.name }
    password { "foobar123" }
    
  end

end
