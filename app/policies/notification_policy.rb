# frozen_string_literal: true

class NotificationPolicy < ApplicationPolicy
  def create?
    user.admin?
  end

  alias_method :can_view_notifications?, :create?
end
