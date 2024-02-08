# frozen_string_literal: true

module Api
  module V1
    class GroupsController < ApplicationController
      def index
        group_ids = current_api_v1_user.user_groups.pluck(:group_id)
        partner_groups = UserGroup.where(group_id: group_ids).where.not(user_id: current_api_v1_user.id).order(created_at: :desc)
        render json: { groups: partner_groups.as_json(include: { user: { only: :name, methods: :profile_image_url } }) }
      end

      def create
        group_ids = current_api_v1_user.user_groups.pluck(:group_id)
        partner_group = UserGroup.find_by(user_id: params[:partner_id], group_id: group_ids)
        if partner_group.blank?
          partner_group = Group.create_talk_room(user: current_api_v1_user, partner_id: params[:partner_id])
          return render json: { error: 'グループの作成に失敗しました' } if partner_group.blank?
        end
        render json: { partner_group: }
      end
    end
  end
end
