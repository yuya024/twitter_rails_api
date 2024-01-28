# frozen_string_literal: true

module Api
  module V1
    class FavoritesController < ApplicationController
      def create
        favorite = current_api_v1_user.favorites.new(favorite_params)
        if favorite.save
          render json: { favorite: }
        else
          render json: { error: 'いいねに失敗しました' }
        end
      end

      private

      def favorite_params
        params.require(:tweet_id)
        params.permit(:tweet_id)
      end
    end
  end
end
