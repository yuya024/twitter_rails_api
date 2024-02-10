# frozen_string_literal: true

class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  has_many :bookmark_folders, dependent: :destroy
  validates :tweet_id, uniqueness: { scope: :user_id }
end
