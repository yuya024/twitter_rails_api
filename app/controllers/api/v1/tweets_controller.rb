# frozen_string_literal: true

module Api
  module V1
    class TweetsController < ApplicationController
      def create
        tweet = current_api_v1_user.tweets.new(tweet_params)
        if tweet.save
          render json: { data: tweet }
        else
          render json: { error: '投稿に失敗しました' }
        end
      end

      private

      def tweet_params
        params.require(:tweet).permit(:content)
      end
    end
  end
end
