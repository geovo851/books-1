FactoryGirl.define do
  factory :book do
    title { Faker::Lorem.characters(rand(4..30)) }
    content { Faker::Lorem.paragraph }

    association :user, factory: :user

    factory :invalid_book do
      title nil
    end
  end
end