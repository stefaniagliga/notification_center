# frozen_string_literal: true

class NotificationSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :description,
             :date,
             :created_by

  def date
    object.date.strftime("%m/%d/%Y")
  end
end