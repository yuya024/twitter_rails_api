# frozen_string_literal: true

class CreateBookmarkFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmark_folders do |t|
      t.references :bookmark, null: false, foreign_key: true
      t.references :folder, null: false, foreign_key: true

      t.timestamps
    end
    add_index :bookmark_folders, %i[bookmark_id folder_id], unique: true
  end
end
