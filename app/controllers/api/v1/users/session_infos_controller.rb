# frozen_string_literal: true

module Api
  module V1
    module Users
      class SessionInfosController < ApplicationController
        def index
          if current_api_v1_user
            render json: { is_login: true, data: current_api_v1_user }, methods: [:profile_image_url]
          else
            render json: { is_login: false, message: 'ユーザーが存在しません' }
          end
        end
      end
    end
  end
end
