# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :user_groups, dependent: :destroy
  has_many :messages, dependent: :destroy

  def self.create_talk_room(user:, partner_id:)
    ActiveRecord::Base.transaction do
      group = Group.create!
      user.user_groups.create!(group_id: group.id)
      UserGroup.create!(user_id: partner_id, group_id: group.id)
    end
  end
end
