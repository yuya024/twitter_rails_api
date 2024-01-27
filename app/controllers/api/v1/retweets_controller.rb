# frozen_string_literal: true

module Api
  module V1
    class RetweetsController < ApplicationController
      def create
        retweet = current_api_v1_user.retweets.new(retweet_params)
        if retweet.save
          render json: { retweet: }
        else
          render json: { error: 'リツイートに失敗しました' }
        end
      end

      private

      def retweet_params
        params.require(:tweet_id)
        params.permit(:tweet_id)
      end
    end
  end
end
