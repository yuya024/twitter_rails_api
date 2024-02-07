# frozen_string_literal: true

module Api
  module V1
    class NotificationsController < ApplicationController
      include Pagination

      def index
        notifications = current_api_v1_user.notifications.page(params[:page] || 1).per(10).order(created_at: :desc)
        render json: { notifications: notifications.as_json(include: { subject: { only: :display, methods: :display } }),
                       pagination: resources_with_pagination(notifications) }
      end
    end
  end
end
