# frozen_string_literal: true

require 'rails_helper'

describe ExtendedUserNotificationSerializer do
  subject { ActiveModelSerializers::Adapter::JsonApi.new(serializer).as_json }

  let(:user_notification) { create(:user_notification, :with_user_and_notification) }
  let(:serializer) { described_class.new(user_notification) }

  let(:expected_json) do
    {
      data: {
        id: user_notification.id.to_s,
        attributes: {
          seen: user_notification.seen
        },
        type: 'user_notifications',
        relationships: {
          notification: {
            data: {
              id: user_notification.notification.id.to_s,
              type: 'notifications'
            }
          }
        }
      }
    }
  end

  it { is_expected.to include(expected_json) }
end
