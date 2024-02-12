# frozen_string_literal: true

module Api
  module V1
    class BookmarkFoldersController < ApplicationController
      def index
        added_bookmark_ids = BookmarkFolder.where(folder_id: params[:folder_id]).pluck(:bookmark_id)
        if params[:is_add].present?
          not_added_bookmarks = current_api_v1_user.bookmarks.where.not(id: added_bookmark_ids).order(created_at: :desc)
          render_json_response(bookmarks: not_added_bookmarks, key: :not_added_bookmarks_to_folder)
        else
          added_bookmarks = current_api_v1_user.bookmarks.where(id: added_bookmark_ids).order(created_at: :desc)
          render_json_response(bookmarks: added_bookmarks, key: :added_bookmarks_to_folder)
        end
      end

      def create
        bookmark_folder = BookmarkFolder.new(bookmark_folder_params)
        if bookmark_folder.save
          render json: { bookmark_folder: }
        else
          render json: { error: 'フォルダへの追加に失敗しました' }
        end
      end

      private

      def bookmark_folder_params
        params.require(:bookmark_folder).permit(:bookmark_id).merge(folder_id: params[:folder_id])
      end

      def render_json_response(bookmarks:, key:)
        render json: { key => bookmarks.as_json(include: { tweet: {
                                                  include: { user: { only: :name, methods: :profile_image_url } },
                                                  methods: %i[image_url comment_count favorite_count retweet_count
                                                              retweeted_by favorited_by bookmarked_by]
                                                } }) }
      end
    end
  end
end
