class NotificationSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :description,
             :date

  def date
    object.date.strftime("%m/%d/%Y")
  end
end