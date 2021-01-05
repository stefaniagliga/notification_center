# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::NotificationsController, type: :request do
  let(:user) { create(:user, :admin) }
  let(:token) { confirm_and_login_user(user) }

  let(:headers) do
    {
      'Authorization' => "Bearer #{token}"
    }
  end

  describe '#index' do
    let(:notifications) do
      create_list(:notification, 5, :with_user_notifications, created_by: user.id)
    end

    before do
      notifications
      get '/api/v1/notifications', headers: headers
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns all notifications created by the user' do
      expect(json_data.count).to eq(notifications.count)
    end

    context 'when user is not admin' do
      let(:user) { create(:user, :client) }

      it 'fails with forbidden status' do
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe '#create' do
    let(:client) { create(:user, :client)}

    before do
      client
      post '/api/v1/notifications', headers: headers, params: params
    end

    context 'when receives correct parameters' do
      let(:params) do
        {
          notification: {
            title: 'Title',
            description: 'Description',
            date: Time.zone.now + 1.day,
            user_ids: [client.id]
          }
        }
      end

      it 'returns 201 status' do
        expect(response).to have_http_status(:created)
      end

      it 'returns a notification object' do
        expect(json_data['type']).to eq 'notifications'
      end

      it 'returns the created notification object' do
        expect(json_data['attributes']['title']).to eq params[:notification][:title]
      end
    end

    context 'when params are missing' do
      let(:params) do
        {
          notification: {
            description: 'Description',
            date: Time.zone.now + 1.day,
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

    context 'when user is not admin' do
      let(:params) do
        {
          notification: {
            description: 'Description',
            date: Time.zone.now + 1.day,
          }
        }
      end
      let(:user) { create(:user, :client) }

      it 'fails with forbidden status' do
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end