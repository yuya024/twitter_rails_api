# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :subject, polymorphic: true
  belongs_to :user

  def self.creation(model:, tweet:)
    if model.instance_of?(Follow)
      Notification.create!(subject: model, user_id: model.followed_id)
    else
      Notification.create!(subject: model, user_id: tweet.user_id)
    end
  end
end
