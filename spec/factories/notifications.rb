FactoryBot.define do
  factory :notification, class: :notification do
    title { 'Title' }
    description { 'Description' }
    date { Time.zone.now - 1.minute }
    created_by { 1 }

    trait :with_user_notifications do
      after(:stub, :build) do |notification|
        user = build(:user, :client)
        notification.user_notifications << build(:user_notification, user: user)
      end
    end
  end
end