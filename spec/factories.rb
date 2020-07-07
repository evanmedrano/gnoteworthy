require 'faker'

FactoryBot.use_parent_strategy = false

FactoryBot.define do
  factory :note do
    association :user
    body { Faker::Lorem.paragraph(sentence_count: 4) }
    category { "Work" }
    password { nil }
    priority { "High" }
    private { false }
    title { "My title" }

    trait :private do
      password { "foobar" }
      private { true }
    end
  end

  factory :user do
    email { Faker::Internet.unique.email }
    name { Faker::Name.name }
    password { "foobar123" }
  end
end
