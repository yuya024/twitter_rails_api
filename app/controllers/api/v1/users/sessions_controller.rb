# frozen_string_literal: true

module Api
  module V1
    module Users
      class SessionsController < DeviseTokenAuth::SessionsController
        def create
          super
          hash = JSON.parse(response.body)
          hash['data']['profile_image_url'] = @resource.profile_image_url
          response.body = hash.to_json
        end
      end
    end
  end
end
