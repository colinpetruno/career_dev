FactoryGirl.define do
  factory :category do
    company
    name { Faker::Lorem.word }

  end
end
