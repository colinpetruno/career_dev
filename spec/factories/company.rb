FactoryGirl.define do
  factory :company do
    billing_plan
    sequence :name do |n|
      "Example Company #{n}"
    end
    sequence :slug do |n|
      "example-company-#{n}"
    end
  end
end
