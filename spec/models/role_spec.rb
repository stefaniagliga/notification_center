# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do
  describe 'Associations' do
    subject { build(:role) }

    it { is_expected.to have_many(:users) }
  end
end
