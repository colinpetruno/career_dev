FactoryGirl.define do
  factory :invitation_token do
    invitation

    email { Faker::Internet.email }
  end
end
