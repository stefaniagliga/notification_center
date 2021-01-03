# frozen_string_literal: true

class NotificationForm
  include ActiveModel::Model

  attr_accessor :user_notifications_attributes, :title, :description, :date

  validates :title, :description, :date, presence: true
  validate :user_ids_exist
  validate :date_cannot_be_in_the_past

  private

  def user_ids_exist
    return if user_notifications_attributes.present?

    error_message = 'Please select at least one client id for this notification'
    errors.add(:user_notifications_attributes, error_message)
  end

  def date_cannot_be_in_the_past
    errors.add(:date, "can't be in the past") if date.present? && date < Time.zone.now
  end
end