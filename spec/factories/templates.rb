FactoryGirl.define do
  factory :template do
    name { Faker::Lorem.sentence }
  end

  factory :template_attributes, class: Hash do
    name { Faker::Lorem.sentence }

    initialize_with { attributes }
  end
end
