# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      include Pagination

      def create
        comment = current_api_v1_user.comments.new(comment_params)
        if comment.save
          tweets = Tweet.page(params[:page] || 1).per(10).order(created_at: :desc)
          render json: { data: tweets.as_json(methods: %i[image_url comment_count],
                                              include: { user: { only: :name, methods: :profile_image_url } }),
                         pagination: resources_with_pagination(tweets) }
        else
          render json: { error: 'コメントの投稿に失敗しました' }
        end
      end

      private

      def comment_params
        params.permit(:tweet_id, :content)
      end
    end
  end
end
