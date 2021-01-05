# frozen_string_literal: true

require 'rails_helper'

describe ExtendedNotificationSerializer do
  subject { ActiveModelSerializers::Adapter::JsonApi.new(serializer).as_json }

  let(:notification) { create(:notification, :with_user_notifications) }
  let(:serializer) { described_class.new(notification) }

  let(:expected_json) do
    {
      data: {
        id: notification.id.to_s,
        attributes: {
          title: notification.title,
          description: notification.description,
          date: notification.date.strftime("%m/%d/%Y"),
          created_by: notification.created_by
        },
        type: 'notifications',
        relationships:{
          user_notifications: {
            data: [{
              id: notification.user_notifications.first.id.to_s,
              type: 'user_notifications'
            }]
          }
        }
      }
    }
  end

  it { is_expected.to include(expected_json) }
end
