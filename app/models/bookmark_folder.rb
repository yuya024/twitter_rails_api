# frozen_string_literal: true

class BookmarkFolder < ApplicationRecord
  belongs_to :bookmark
  belongs_to :folder
  validates :bookmark_id, uniqueness: { scope: :folder_id }
end
