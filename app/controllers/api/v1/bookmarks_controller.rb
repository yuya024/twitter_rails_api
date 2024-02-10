# frozen_string_literal: true

module Api
  module V1
    class BookmarksController < ApplicationController
      include Pagination
      def index
        bookmarks = current_api_v1_user.bookmarks.page(params[:page] || 1).per(10).order(created_at: :desc)
        render json: { bookmarks: bookmarks.as_json(include: { tweet: { include: { user: { only: :name,
                                                                                           methods: :profile_image_url } },
                                                                        methods: %i[image_url comment_count favorite_count
                                                                                    retweet_count retweeted_by favorited_by
                                                                                    bookmarked_by] } }),
                       pagination: resources_with_pagination(bookmarks) }
      end

      def create
        bookmark = current_api_v1_user.bookmarks.new(bookmark_params)
        if bookmark.save
          render json: { bookmark: }
        else
          render json: { error: 'ブックマークの作成に失敗しました' }
        end
      end

      def destroy
        bookmark = Bookmark.find(params[:id])
        if bookmark.destroy
          render json: { bookmark: }
        else
          render json: { error: 'ブックマークの削除に失敗しました' }
        end
      end

      private

      def bookmark_params
        params.require(:bookmark).permit(:tweet_id)
      end
    end
  end
end
