# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates :content, presence: true, length: { maximum: 140 }
end
