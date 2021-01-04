# frozen_string_literal: true

class UserNotificationSerializer < ActiveModel::Serializer
  attributes :id, :seen
end