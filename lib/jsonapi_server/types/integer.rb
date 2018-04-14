# frozen_string_literal: true

module JSONAPI
  class Server
    module Types
      class Integer < Type
        def deserialize(value)
          case value
          when nil
            nil
          when ::String
            return nil if value.empty?

            begin
              Integer(value, 10)
            rescue ArgumentError
              invalid_value_type(value)
            end
          when ::Integer
            value
          else
            invalid_value_type(value)
          end
        end
      end
    end
  end
end
