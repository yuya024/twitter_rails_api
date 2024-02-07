# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notification

  def create_notification
    Notification.creation(model: self, tweet: nil)
  end

  def display
    user = User.find(follower_id)
    "#{user.name}さんにフォローされました"
  end
end
