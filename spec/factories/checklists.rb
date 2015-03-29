FactoryGirl.define do
  factory :checklist do
    name "My checklist"
  end
  
  factory :checklist_attributes, class: Hash do
    name Faker::Lorem.sentence
    
    initialize_with { attributes }
  end
end
