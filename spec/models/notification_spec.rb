# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notification, type: :model do
  subject { create(:notification) }

  describe 'Associations' do
    it { is_expected.to have_many(:user_notifications) }
    it { is_expected.to have_many(:users).through(:user_notifications) }
  end

  describe 'Validations' do
    describe '#title' do
      it { is_expected.to validate_presence_of(:title) }
    end

    describe '#description' do
      it { is_expected.to validate_presence_of(:description) }
    end

    describe '#date' do
      it { is_expected.to validate_presence_of(:date) }
    end
  end
end
