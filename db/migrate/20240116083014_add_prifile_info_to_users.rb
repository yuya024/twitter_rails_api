# frozen_string_literal: true

class AddPrifileInfoToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :introduction, limit: 160
      t.string :location, limit: 30
      t.string :website, limit: 100
      t.datetime :birthdate
    end
  end
end
