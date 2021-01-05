# frozen_string_literal: true

class NotificationForm
  include ActiveModel::Model

  attr_accessor :user_ids, :title, :description, :date

  validates :title, :description, :date, presence: true
  validate :user_ids_exist
  validate :date_cannot_be_in_the_past

  private

  def user_ids_exist
    return unless user_ids.present?
    return if all_user_ids_exist?

    msg = "User ids contains ids that do not belong to any user: #{annonymous_user_ids.join(',')}"
    errors.add(:user_ids, msg)
  end

  def date_cannot_be_in_the_past
    errors.add(:date, "can't be in the past") if date.present? && date < Time.zone.now
  end

  def all_user_ids_exist?
    true if annonymous_user_ids.empty?
  end

  def annonymous_user_ids
    user_ids.map(&:to_i) - User.where(id: user_ids).pluck(:id)
  end
end