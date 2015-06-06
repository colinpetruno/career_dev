FactoryGirl.define do
  factory :file, class: Attachinary::File do
    sequence(:public_id) { |n| "id#{n}"}
    sequence(:version) { |n| "#{n}"}
    width 800
    height 600
    format 'jpg'
    resource_type 'image'
  end
end
