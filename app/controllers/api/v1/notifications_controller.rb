# frozen_string_literal: true

module Api
  module V1
    class NotificationsController < ApplicationController
      before_action :authenticate

      def create
        # only admins create notifications
        notification_context = create_notification

        if notification_context.success?
          render json: notification_context.notification,
                 serializer: NotificationSerializer,
                 status: :created,
                 adapter: :json_api
        else
          render json: notification_context.errors, status: :unprocessable_entity
        end
      end

      private

      def create_notification
        @notification_context ||=
          CreateNotificationInteractor.call(notification_form: notification_form,
                                            notification_params: notification_params,
                                            current_user: User.first)
      end

      def notification_form
        @notification_form ||= NotificationForm.new(notification_params)
      end

      def notification_params
        params.require(:notification).permit(:title,
                                             :description,
                                             :date,
                                             user_notifications_attributes: [:user_id])
      end
    end
  end
end