# frozen_string_literal: true

class Tweet < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :image

  def image_url
    image.attached? ? url_for(image) : nil
  end

  def comment_count
    comments.count
  end

  def retweet_count
    retweets.count
  end

  def favorite_count
    favorites.count
  end

  def retweeted_by
    retweets.exists?(user_id: $current_api_v1_user.id)
  end

  def favorited_by
    favorites.exists?(user_id: $current_api_v1_user.id)
  end
end
