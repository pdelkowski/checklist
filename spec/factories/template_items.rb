FactoryGirl.define do
  factory :template_item do
    name { Faker::Lorem.sentence }
    association :template
  end

  factory :template_item_attributes, class: Hash do
    name { Faker::Lorem.sentence }
    
    initialize_with { attributes }
  end
end
