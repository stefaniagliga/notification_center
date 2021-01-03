# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      before_action :find_user, only: :create

      def create
        if @user && @user.authenticate(params[:password])
          token = JsonWebToken.encode({ user_id: @user.id })
          render json: { user: @user, token: token }
        else
          render json: { error: 'Invalid username or password' }
        end
      end

      def delete

      end

      private

      def find_user
        @user ||= User.find_by(email: params[:email])
      end
    end
  end
end
