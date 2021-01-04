# frozen_string_literal: true

class UpdateUserNotificationInteractor
  include Interactor

  delegate :form, :params, :user_notification, :current_user, to: :context

  # @!method self.call(form:, params:, user_notification:, current_user:)
  #   @param [UserNotificationUpdateForm] User Notification form object
  #   @param [Hash] User Notification params
  #   @param [UserNotification] User Notification object
  # @!visibility private
  def call
    check_form_errors
    update_user_notification
  end

  private

  def check_form_errors
    context.fail!(errors: form.errors.messages) if form.invalid?
  end

  def update_user_notification
    if user_notification.update_attributes(params)
      context.updated_user_notification = user_notification
    else
      context.fail!(errors: :failed_to_save)
    end
  end
end