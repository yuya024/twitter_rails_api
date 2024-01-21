# frozen_string_literal: true

module Api
  module V1
    class ProfilesController < ApplicationController
      def update
        if current_api_v1_user
          if current_api_v1_user.update(profile_params)
            render json: { data: current_api_v1_user.as_json(methods: %i[profile_image_url header_image_url]) }
          else
            render json: { message: '更新に失敗しました' }
          end
        else
          render json: { message: 'ユーザーが存在しません' }
        end
      end

      private

      def profile_params
        params.permit(:name, :introduction, :location, :website, :birthdate, :profile_image, :header_image)
      end
    end
  end
end
