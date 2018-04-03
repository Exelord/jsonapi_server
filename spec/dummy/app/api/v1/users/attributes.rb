# frozen_string_literal: true

module Api
  module V1
    module Users
      class Attributes < JSONAPI::Server::Attributes
        attributes :name, :email

        def name=(value)
          model.name = value.camelize
        end

        def name
          "Username: #{model.name}"
        end
      end
    end
  end
end
