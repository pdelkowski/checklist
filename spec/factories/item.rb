FactoryGirl.define do
  factory :item do
    description Faker::Lorem.sentence
    association :checklist

    factory :item_completed do
      completed_at Time.now
    end
  end
  
  factory :item_attributes, class: Hash do
    description Faker::Lorem.sentence
    
    initialize_with { attributes }
  end
end
