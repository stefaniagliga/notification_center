# frozen_string_literal: true

class ExtendedNotificationSerializer < NotificationSerializer
  has_many :user_notifications, serializer: UserNotificationSerializer
end