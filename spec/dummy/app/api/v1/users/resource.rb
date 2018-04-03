# frozen_string_literal: true

module Api
  module V1
    module Users
      class Resource < JSONAPI::Server::Resource
        def destory
          model.destroy
        end
      end
    end
  end
end
