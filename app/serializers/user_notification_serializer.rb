# frozen_string_literal: true

class UserNotificationSerializer < ActiveModel::Serializer
  attributes :seen

  has_one :notification, serializer: NotificationSerializer
end