FactoryGirl.define do
  factory :company do

    sequence :id
    sequence :name do |n|
      "Example Company #{n}"
    end
    sequence :slug do |n|
      "example-company-#{n}"
    end

    after(:build) do |company|
      unless company.subscription
        subscription = build(:subscription)
        company.subscription = subscription
      end
    end

    factory :company_with_tasks do
      transient do
        tasks_count 30
      end

      after(:create) do |company, evaluator|
        create_list(:task, evaluator.tasks_count, company_id: company.id)
      end
    end

  end
end
