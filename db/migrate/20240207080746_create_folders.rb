# frozen_string_literal: true

class CreateFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :folders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
    add_index :folders, %i[user_id name], unique: true
  end
end
