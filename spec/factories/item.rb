FactoryGirl.define do
  factory :item do
    description Faker::Lorem.sentence
    association :checklist
  end
end
