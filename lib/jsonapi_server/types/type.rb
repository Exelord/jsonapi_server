# frozen_string_literal: true

# TODO: Missing types
# time*
# decimal*

module JSONAPI
  class Server
    module Types
      class Type
        def deserialize(value)
          value
        end

        def serialize(value)
          value
        end

        protected

        def type
          @type ||= self.class.name.demodulize.underscore
        end

        def invalid_value_type(value)
          raise(Exceptions::InvalidType.new(type, value))
        end
      end
    end
  end
end
