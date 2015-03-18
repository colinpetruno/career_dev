FactoryGirl.define do
  factory :billing_plan do
    sequence :name do |n|
      "billing plan #{n}"
    end
    monthly_cost 2500
    yearly_cost 250000
    active true
  end
end
