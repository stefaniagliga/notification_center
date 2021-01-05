# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    subject { build(:user) }

    it { is_expected.to belong_to(:role) }
    it { is_expected.to have_many(:notifications).through(:user_notifications) }
    it { is_expected.to have_many(:user_notifications) }
  end

  describe '#admin?' do
    context 'when user is admin' do
      subject(:user) { create(:user, :admin) }

      it 'returns true' do
        expect(user.admin?).to be(true)
      end
    end

    context 'when user is client' do
      subject(:user) { create(:user, :client) }

      it 'returns false' do
        expect(user.admin?).to be(false)
      end
    end
  end

  describe '#client?' do
    context 'when user is admin' do
      subject(:user) { create(:user, :admin) }

      it 'returns false' do
        expect(user.client?).to be(false)
      end
    end

    context 'when user is client' do
      subject(:user) { create(:user, :client) }

      it 'returns true' do
        expect(user.client?).to be(true)
      end
    end
  end
end
