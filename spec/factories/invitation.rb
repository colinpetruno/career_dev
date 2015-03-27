FactoryGirl.define do
  factory :invitation do
    company
    user

    emails { "#{Faker::Internet.email}, #{Faker::Internet.email}" }
  end
end
