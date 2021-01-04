# frozen_string_literal: true

class ExtendedUserNotificationSerializer < UserNotificationSerializer
  has_one :notification, serializer: NotificationSerializer
end