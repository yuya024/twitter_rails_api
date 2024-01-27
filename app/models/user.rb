# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include DeviseTokenAuth::Concerns::User
  include Rails.application.routes.url_helpers
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :profile_image
  has_one_attached :header_image

  def setup_default_image
    profile_image.attach(io: Rails.root.join('app/assets/images/default_profile.jpg').open,
                         filename: 'default_profile.jpg')
    header_image.attach(io: Rails.root.join('app/assets/images/default_header.jpg').open,
                        filename: 'default_header.jpg')
  end

  def profile_image_url
    profile_image.attached? ? url_for(profile_image) : nil
  end

  def header_image_url
    header_image.attached? ? url_for(header_image) : nil
  end
end
