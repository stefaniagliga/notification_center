# frozen_string_literal: true

class CreateNotificationInteractor
  include Interactor

  delegate :notification_form, :current_user, :notification_params,to: :context

  # @!method self.call(notification_form:, current_user:, notification_params:)
  #   @param [NotificationForm] Notification form object
  #   @param [User] Current user
  #   @param [Hash] Notification params
  # @!visibility private
  def call
    check_form_errors
    create_notification
  end

  private

  def check_form_errors
    context.fail!(errors: notification_form.errors.messages) if notification_form.invalid?
  end

  def create_notification
    add_user_ids_params

    notification = Notification.new(stamped_notification_params)

    if notification.save
      context.notification = notification
    else
      context.fail!(errors: :failed_to_save)
    end
  end

  def stamped_notification_params
    notification_params[:created_by] = current_user.id

    notification_params
  end

  def add_user_ids_params
    return if notification_params[:user_ids]

    user_ids = User.pluck(:id)
    notification_params[:user_ids] = user_ids
  end
end