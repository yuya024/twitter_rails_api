# frozen_string_literal: true

class Tweet < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image

  def image_url
    image.attached? ? url_for(image) : nil
  end

  def comment_count
    comments.count
  end
end
