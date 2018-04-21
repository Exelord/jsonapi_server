# frozen_string_literal: true

module JSONAPI
  class Server
    module Types
      class String < Type
        def deserialize(value)
          case value
          when nil
            ''
          when ::String
            value
          when ::Numeric
            value.to_s
          else
            invalid_value_type(value)
          end
        end
      end
    end
  end
end
