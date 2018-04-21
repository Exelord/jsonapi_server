# frozen_string_literal: true

module JSONAPI
  class Server
    module Types
      class DateTime < Type
        def type
          'DateTime [ISO8601]'
        end

        def deserialize(value)
          case value
          when nil
            nil
          when ::String
            return nil if value.empty?

            begin
              ::Time.iso8601(value)
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
