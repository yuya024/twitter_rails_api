# frozen_string_literal: true

module Api
  module V1
    class FollowsController < ApplicationController
      def create
        followed_user = current_api_v1_user.follower.new(followed_id: params[:user_id])
        if followed_user.save
          render json: { followed_user: followed_user }
        else
          render json: { error: "フォローに失敗しました"}
        end
      end
    end
  end
end
