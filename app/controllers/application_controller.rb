# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def authenticate
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end

  def current_user
    return nil unless logged_in?
    logged_in_user
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def decoded_token
    JsonWebToken.decode(auth_header.split(' ')[1]) if auth_header
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[:user_id]
      @user ||= User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def user_not_authorized
    render json: { errors: 'User not authorized to perform this operation' },
           status: :forbidden
  end

  def include_params
    (params[:include].to_s.split(',') & permitted_include_params).uniq
  end

  def permitted_include_params
    %w[]
  end
end
