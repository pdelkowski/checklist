FactoryGirl.define do
  factory :template_item do
    name { Faker::Lorem.sentence }
    association :template
  end

end
