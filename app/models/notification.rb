# frozen_string_literal: true

class Notification < ApplicationRecord
  has_many :user_notifications
  has_many :users, through: :user_notifications

  validates :title, :description, :date, presence: true
end