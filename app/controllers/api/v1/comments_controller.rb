# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      include Pagination

      def index
        tweet = Tweet.find(params[:tweet_id])
        comments = Comment.where(tweet_id: params[:tweet_id]).page(params[:page] || 1).per(10).order(created_at: :desc)
        render json: {
          tweet: tweet.as_json(methods: %i[image_url comment_count],
                               include: { user: { only: :name,
                                                  methods: :profile_image_url } }),
          comments: comments.as_json(include: { user: { only: :name, methods: :profile_image_url } }),
          pagination: resources_with_pagination(comments)
        }
      end

      def create
        comment = current_api_v1_user.comments.new(comment_params)
        if comment.save
          render json: { comment: }
        else
          render json: { error: 'コメントの投稿に失敗しました' }
        end
      end

      def destroy
        comment = Comment.find(params[:id])
        if comment.destroy
          render json: { comment: }
        else
          render json: { error: 'コメントの削除に失敗しました' }
        end
      end

      private

      def comment_params
        params.permit(:tweet_id, :content)
      end
    end
  end
end
