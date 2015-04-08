FactoryGirl.define do
  factory :user do
    company
    first_name "Example"
    last_name "User"
    email { Faker::Internet.email }
    password "asdf1234"
    password_confirmation "asdf1234"
  end
end
