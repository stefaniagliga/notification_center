# frozen_string_literal: true

class NotificationForm
  include ActiveModel::Model

  attr_accessor :user_ids, :title, :description, :date

  validates :title, :description, :date, presence: true
  validate :user_ids_exist
  validate :date_cannot_be_in_the_past

  private

  def user_ids_exist
    return if user_ids.present?

    error_message = 'Please select at least one client id for this notification'
    errors.add(:user_ids, error_message)
  end

  def date_cannot_be_in_the_past
    errors.add(:date, "can't be in the past") if date.present? && date < Time.zone.now
  end
end