FactoryGirl.define do
  factory :offer do
    user
    task
    accepted false
    approved false
    completed false
  end
  # #<Offer id: 4, user_id: 1, task_id: 1, created_at: "2015-04-11 20:56:32", updated_at: "2015-04-11 20:56:32", accepted: false, approved: false, completed: false>
end
