# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notification

  def create_notification
    Notification.creation(model: self, tweet:)
  end

  def display
    user = User.find(user_id)
    "#{user.name}さんにいいねされました"
  end
end
