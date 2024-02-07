# frozen_string_literal: true

module Api
  module V1
    class MessagesController < ApplicationController
      def index
        messages = Message.where(group_id: params[:group_id])
        render json: { data: messages }
      end

      def create
        message = current_api_v1_user.messages.new(message_params)
        if message.save
          render json: { message: }
        else
          render json: { error: 'メッセージの作成に失敗しました' }
        end
      end

      private

      def message_params
        params.require(:message).permit(:content).merge(group_id: params[:group_id])
      end
    end
  end
end
