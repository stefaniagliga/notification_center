# frozen_string_literal: true

require 'rails_helper'

describe UserSerializer do
  subject { ActiveModelSerializers::Adapter::JsonApi.new(serializer).as_json }

  let(:user) { create(:user, :admin) }
  let(:serializer) { described_class.new(user) }

  let(:expected_json) do
    {
      data: {
        id: user.id.to_s,
        attributes: {
          name: user.name
        },
        type: 'users'
      }
    }
  end

  it { is_expected.to include(expected_json) }
end
