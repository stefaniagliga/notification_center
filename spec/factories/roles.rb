FactoryBot.define do
  factory :role, class: :role do
    trait :admin do
      name { 'admin' }
    end

    trait :client do
      name { 'client' }
    end
  end
end