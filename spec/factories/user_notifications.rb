FactoryBot.define do
  factory :user_notification, class: :user_notification do

    trait :with_user_and_notification do
      after(:stub, :build) do |user_notification|
        user_notification.notification = build(:notification)
        user_notification.user = build(:user, :client)
      end
    end

    trait :with_notification do
      after(:stub, :build) do |user_notification|
        user_notification.notification = build(:notification)
      end
    end
  end
end