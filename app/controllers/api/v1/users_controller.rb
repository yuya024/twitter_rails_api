# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      include Pagination

      def show
        user = User.find(params[:id])
        tweets = user.tweets.page(params[:page] || 1).per(10).order(created_at: :desc)
        render json: { user: user.as_json(methods: %i[profile_image_url header_image_url]),
                       tweets: tweets.as_json(methods: :image_url), pagination: resources_with_pagination(tweets) }
      end
    end
  end
end
