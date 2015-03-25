FactoryGirl.define do
  factory :checklist_item do
    name { Faker::Lorem.sentence }
    association :checklist
  end

end
