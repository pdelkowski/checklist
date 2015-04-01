FactoryGirl.define do
  factory :checklist do
    name { Faker::Lorem.sentence }
  end
  
  factory :checklist_attributes, class: Hash do
    name Faker::Lorem.sentence
    
    initialize_with { attributes }
  end
end
