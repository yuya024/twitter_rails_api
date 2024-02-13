# frozen_string_literal: true

module Api
  module V1
    module Users
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        def create
          super
          @resource.setup_default_image
        end

        def destroy
          group_ids = @resource.user_groups.pluck(:group_id)
          groups = Group.where(id: group_ids)
          groups.each(&:destroy!)
          super
        end

        private

        def sign_up_params
          params.permit(:email, :password, :password_confirmation, :name)
        end
      end
    end
  end
end
