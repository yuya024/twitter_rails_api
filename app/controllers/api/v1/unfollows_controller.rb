# frozen_string_literal: true

module Api
  module V1
    class UnfollowsController < ApplicationController
      def destroy
        unfollowed_user = current_api_v1_user.follower.find_by(followed_id: params[:user_id])
        if unfollowed_user.destroy
          render json: { unfollowed_user: }
        else
          render json: { error: 'フォロー解除に失敗しました' }
        end
      end
    end
  end
end
