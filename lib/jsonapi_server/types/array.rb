# frozen_string_literal: true

module JSONAPI
  class Server
    module Types
      class Array < Type
        def deserialize(value)
          case value
          when nil
            []
          when ::Array
            value
          else
            invalid_value_type(value)
          end
        end
      end
    end
  end
end
