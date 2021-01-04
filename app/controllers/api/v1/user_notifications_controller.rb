# frozen_string_literal: true

module Api
  module V1
    class UserNotificationsController < ApplicationController
      before_action :authenticate

      def index
        user_notifications = UserNotification
                               .includes(:notification)
                               .where(user_id: current_user.id)
                               .where('notifications.date <= ?', Time.zone.now)
                               .order('notifications.date DESC')

        render json: user_notifications,
               each_serializer: ExtendedUserNotificationSerializer,
               include: include_params,
               adapter: :json_api
      end

      def update
        authorize user_notification

        if update_user_notification_context.success?
          render json: update_user_notification_context.updated_user_notification,
                 serializer: ExtendedUserNotificationSerializer,
                 include: include_params,
                 adapter: :json_api
        else
          render json: update_user_notification_context.errors, status: :unprocessable_entity
        end
      end

      private

      def update_user_notification_context
        @user_notification_context ||=
          UpdateUserNotificationInteractor.call(form: user_notification_update_form,
                                                params: user_notification_params,
                                                user_notification: user_notification,
                                                current_user: current_user)
      end

      def user_notification
        @user_notification ||= UserNotification.find(params[:id])
      end

      def user_notification_update_form
        @form ||= UserNotificationUpdateForm.new(user_notification_params)
      end

      def user_notification_params
        params.require(:user_notification).permit(:seen)
      end

      def permitted_include_params
        %w[notification]
      end
    end
  end
end
