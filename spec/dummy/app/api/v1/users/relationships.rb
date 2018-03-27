module API
  module V1
    module Users
      class Relationships < JSONAPI::Server::Relationships
        belongs_to :profile
        has_many :accounts
      end
    end
  end
end

