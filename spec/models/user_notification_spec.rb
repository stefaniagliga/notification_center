# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserNotification, type: :model do
  describe 'Associations' do
    subject { build(:user_notification) }

    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:notification) }
  end
end
