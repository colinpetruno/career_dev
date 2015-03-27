FactoryGirl.define do
  factory :task do
    company
    user
    category

    sequence :title do |n|
      "Task Blah #{n}"
    end

    sequence :description do |n|
      "Task Description #{n}"
    end

    difficulty { rand((1..5)) }
    size { rand((1..5)) }
    fun_factor { rand((1..5)) }

    # company
  end
end

  # <Task id: nil, title: nil, difficulty: nil, fun_factor: nil, size: nil, created_at: nil, updated_at: nil, closed: false, company_id: nil, user_id: nil, description: nil, category_id: nil>
