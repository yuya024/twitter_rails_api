# frozen_string_literal: true

module Api
  module V1
    class ImagesController < ApplicationController
      def create
        tweet = Tweet.find(params[:tweet_id])

        if tweet.update(tweet_image_params)
          render json: { data: tweet }
        else
          render json: { error: '画像の投稿に失敗しました' }
        end
      end

      private

      def tweet_image_params
        params.require(:image)
        params.permit(:image)
      end
    end
  end
end
