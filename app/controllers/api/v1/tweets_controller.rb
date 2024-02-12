# frozen_string_literal: true

module Api
  module V1
    class TweetsController < ApplicationController
      include Pagination

      def index
        tweets = Tweet.page(params[:page] || 1).per(10).order(created_at: :desc)
        render json: {
          data: tweets.as_json(methods: %i[image_url comment_count retweet_count favorite_count
                                           retweeted_by favorited_by bookmarked_by login_user_bookmark],
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

      def destroy
        tweet = Tweet.find(params[:id])
        if tweet.destroy
          tweets = current_api_v1_user.tweets.page(1).per(10).order(created_at: :desc)
          render json: { tweets: tweets.as_json(methods: :image_url), pagination: resources_with_pagination(tweets) }
        else
          render json: { error: '投稿の削除に失敗しました' }
        end
      end

      private

      def tweet_params
        params.require(:tweet).permit(:content)
      end
    end
  end
end
