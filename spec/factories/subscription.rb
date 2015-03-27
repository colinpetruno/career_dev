FactoryGirl.define do
  factory :subscription do

    association :billing_plan, strategy: :create
    frequency "monthly"
    active true

    after(:build) do |subscription|
      unless subscription.company
        company = build(:company, subscription: subscription)
        subscription.company = company
      end
    end
  end
end
