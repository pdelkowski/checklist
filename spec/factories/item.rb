FactoryGirl.define do
  factory :item do
    description Faker::Lorem.sentence
    association :checklist

    factory :item_completed do
      completed_at Time.now
    end
  end
end
