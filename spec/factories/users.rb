FactoryGirl.define do
  factory :user do
    name { Faker::Lorem.characters(rand(4..30)) }
    email { Faker::Internet.email }
    password { "user_pass#{ Faker::Internet.password }" }

    association :role, factory: :role
  end
end