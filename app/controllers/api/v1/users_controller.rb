# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      include Pagination

      def show
        user = User.find(params[:id])
        if params[:is_comment].present?
          comments = user.comments.page(params[:page] || 1).per(10).order(created_at: :desc)
          render json: { user: user.as_json(methods: %i[profile_image_url header_image_url]),
                         comments:, pagination: resources_with_pagination(comments) }
        else
          tweets = user.tweets.page(params[:page] || 1).per(10).order(created_at: :desc)
          render json: { user: user.as_json(methods: %i[profile_image_url header_image_url]),
                         tweets: tweets.as_json(methods: %i[image_url comment_count]),
                         pagination: resources_with_pagination(tweets) }
        end
      end
    end
  end
end
