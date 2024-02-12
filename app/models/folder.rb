# frozen_string_literal: true

class Folder < ApplicationRecord
  belongs_to :user
  has_many :bookmark_folders, dependent: :destroy
  validates :name, uniqueness: { scope: :user_id }, presence: true, length: { maximum: 50 }
end
