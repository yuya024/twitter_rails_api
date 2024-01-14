# frozen_string_literal: true

module Api
  module V1
    class TweetsController < ApplicationController
      include Pagination

      def index
        tweets = Tweet.page(params[:page] || 1).per(10).order(created_at: :desc)
        render json: {
          data: tweets.as_json(methods: :image_url,
                               include: { user: { only: :name,
                                                  methods: :profile_image_url } }), pagination: resources_with_pagination(tweets)
        }
      end

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
