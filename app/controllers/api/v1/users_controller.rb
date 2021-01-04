# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate

      def index
        authorize :user, :can_search_users?

        users = User.where('name ILIKE ?', "%#{filter_params[:name]}%")

        render json: users,
               each_serializer: UserSerializer,
               adapter: :json_api
      end

      private

      def filter_params
        params.fetch(:filter, {}).permit(:name)
      end
    end
  end
end
