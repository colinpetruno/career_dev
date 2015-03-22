FactoryGirl.define do
  factory :registration do
    skip_create

    sequence :company_name do |n|
      "Example Company #{n}"
    end

    sequence :email do |n|
      "example#{n}@example.com"
    end

    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password "test1234"
    password_confirmation "test1234"
    frequency "monthly"

    after(:build) do |registration|
      billing_plan = create(:billing_plan)
      registration.plan_id = billing_plan.id
    end
  end
end
