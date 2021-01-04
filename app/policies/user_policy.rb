# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def can_search_users?
    user.admin?
  end
end
