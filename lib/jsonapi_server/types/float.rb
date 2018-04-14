# frozen_string_literal: true

module JSONAPI
  class Server
    module Types
      class Float < Type
        def deserialize(value)
          case value
          when nil
            nil
          when ::String
            return nil if value.empty?

            begin
              Float(value)
            rescue ArgumentError
              invalid_value_type(value)
            end
          when ::Numeric
            Float(value)
          else
            invalid_value_type(value)
          end
        end
      end
    end
  end
end
