# frozen_string_literal: true

class UserNotificationUpdateForm
  include ActiveModel::Model

  attr_accessor :seen

  validates :seen, inclusion: { in: ['true'] }
end