FactoryGirl.define do
  factory :user do
    company
    first_name "Example"
    last_name "User"
    email { Faker::Internet.email }
    password "asdf1234"
    password_confirmation "asdf1234"

    trait :is_company_admin do
      role "Company Admin"
    end

    trait :with_avatar do
      avatar { FactoryGirl.build(:file) }
    end

    factory :company_admin, traits: [:is_company_admin]
  end


end
