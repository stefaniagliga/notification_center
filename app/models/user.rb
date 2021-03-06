# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :role
  has_many :user_notifications
  has_many :notifications, through: :user_notifications

  has_secure_password

  def admin?
    role.name == 'admin'
  end

  def client?
    role.name == 'client'
  end
end