FactoryGirl.define do
  factory :company do
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

    trait :with_tasks do
      ignore do
        tasks_count 30
      end

      after(:create) do |company, evaluator|
        create_list(
          :task,
          evaluator.tasks_count,
          company: company
        )
      end
    end

  end
end
