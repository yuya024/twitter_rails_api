# frozen_string_literal: true

module Api
  module V1
    class FoldersController < ApplicationController
      def index
        folders = current_api_v1_user.folders.order(created_at: :desc)
        render json: { folders: }
      end

      def create
        folder = current_api_v1_user.folders.new(folder_params)
        if folder.save
          render json: { folder: }
        else
          render json: { error: 'フォルダの作成に失敗しました' }
        end
      end

      def destroy
        folder = Folder.find(params[:id])
        if folder.destroy
          render json: { folder: }
        else
          render json: { error: 'フォルダの削除に失敗しました' }
        end
      end

      private

      def folder_params
        params.require(:folder).permit(:name)
      end
    end
  end
end
