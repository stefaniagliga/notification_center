# frozen_string_literal: true

class UserNotificationPolicy < ApplicationPolicy
  def update?
    record.user_id == user.id
  end
end
