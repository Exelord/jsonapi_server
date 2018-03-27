module API
  module V1
    module Users
      class Attributes < JSONAPI::Server::Attributes
        attributes :name, :email

        def name=(value)
          value.camelize
        end

        def name
          "Username: #{model.name}"
        end
      end
    end
  end
end
