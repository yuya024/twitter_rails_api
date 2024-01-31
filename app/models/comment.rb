# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  has_one :notification, as: :subject, dependent: :destroy
  validates :content, presence: true, length: { maximum: 140 }

  after_create_commit :create_notification

  def create_notification
    Notification.creation(model: self, tweet:)
  end

  def display
    user = User.find(user_id)
    "#{user.name}さんにコメントされました"
  end
end
