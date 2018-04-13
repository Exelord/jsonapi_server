# frozen_string_literal: true

module Api
  module V1
    module Users
      class Relationships < JSONAPI::Server::Relationships
        belongs_to :account
      end
    end
  end
end
