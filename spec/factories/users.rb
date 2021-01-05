FactoryBot.define do
  factory :user, class: :user do
    sequence(:email) { |n| "john.doe#{n}@example.com" }
    name { 'John Doe' }
    password { 'blabla' }

    trait :admin do
      after(:stub, :build) do |user|
        user.role = (Role.find_by_name('admin') || build(:role, :admin))
      end
    end

    trait :client do
      after(:stub, :build) do |user|
        user.role = (Role.find_by_name('client') || build(:role, :client))
      end
    end
  end
end