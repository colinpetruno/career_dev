FactoryGirl.define do
  factory :user do
    company
    first_name "Example"
    last_name "User"
    sequence :email do |n|
      "example#{n}@example.com"
    end
    password "asdf1234"
    password_confirmation "asdf1234"
  end
end
