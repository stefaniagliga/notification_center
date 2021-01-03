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
               each_serializer: UserNotificationSerializer,
               include: include_params,
               adapter: :json_api
      end

      private

      def permitted_include_params
        %w[notification]
      end
    end
  end
end
