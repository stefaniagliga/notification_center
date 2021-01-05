# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::UserNotificationsController, type: :request do
  let(:user) { create(:user, :client) }
  let(:token) { confirm_and_login_user(user) }

  let(:headers) do
    {
      'Authorization' => "Bearer #{token}"
    }
  end

  describe '#index' do
    let(:user_notifications) do
      create_list(:user_notification, 5, :with_notification, user_id: user.id)
    end

    before do
      user_notifications
      get '/api/v1/user_notifications', headers: headers
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns all notifications for the user' do
      expect(json_data.count).to eq(user_notifications.count)
    end
  end

  describe '#update' do
    before do
      patch "/api/v1/user_notifications/#{user_notification.id}", headers: headers, params: params
    end

    context 'when updating own user_notification' do
      let(:user_notification) { create(:user_notification, :with_notification, user_id: user.id) }
      let(:params) do
        {
          user_notification: {
            seen: true
          }
        }
      end

      it 'returns 200 status' do
        expect(response).to have_http_status(:success)
      end

      it 'returns a user notification object' do
        expect(json_data['type']).to eq 'user_notifications'
      end

      it 'returns the updated notification object' do
        expect(json_data['attributes']['seen']).to eq params[:user_notification][:seen]
      end
    end

    context 'when updating the user_notification of somebody else' do
      let(:user2) { create(:user, :client) }
      let(:user_notification) { create(:user_notification, :with_notification, user_id: user2.id) }
      let(:params) do
        {
          user_notification: {
            seen: true
          }
        }
      end

      it 'returns 403 status' do
        expect(response).to have_http_status(:forbidden)
      end

      it 'returns an error response' do
        expect(json.keys).to include('errors')
      end
    end

    context 'when params are incorrect' do
      let(:user_notification) { create(:user_notification, :with_notification, user_id: user.id) }
      let(:params) do
        {
          user_notification: {
            seen: false
          }
        }
      end

      it 'returns 422 status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error response' do
        expect(json.keys).to include('errors')
      end
    end
  end
end