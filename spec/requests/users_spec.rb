# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::UsersController, type: :request do
  let(:user) { create(:user, :admin) }
  let(:token) { confirm_and_login_user(user) }

  let(:headers) do
    {
      'Authorization' => "Bearer #{token}"
    }
  end

  describe '#index' do
    let(:users) do
      create_list(:user, 5, :client, name: 'Lola')
    end

    let(:filters) { {} }

    before do
      users
      get '/api/v1/users', headers: headers, params: filters
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns all users' do
      expect(json_data.count).to eq(6)
    end

    context 'when searching' do
      let(:filters) { { filter: { name: 'Name' } } }

      it 'returns 0 users' do
        expect(json_data.count).to eq(0)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not admin' do
      let(:user) { create(:user, :client) }

      it 'fails with forbidden status' do
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
