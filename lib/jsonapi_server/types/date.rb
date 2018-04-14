# frozen_string_literal: true

module JSONAPI
  class Server
    module Types
      class Date < Type
        def type
          'Date [ISO8601]'
        end

        def deserialize(value)
          case value
          when nil
            nil
          when ::String
            return nil if value.empty?

            begin
              ::Date.iso8601(value)
            rescue ArgumentError
              invalid_value_type(value)
            end
          else
            invalid_value_type(value)
          end
        end
      end
    end
  end
end
