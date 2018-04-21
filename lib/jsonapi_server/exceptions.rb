# frozen_string_literal: true

module JSONAPI
  class Server
    class Exceptions
      class Error < StandardError
        # code
      end

      class InvalidType < Error
        def initialize(type, value)
          @type = type
          @value = value
        end

        def message
          "Invalid value type! Expected value of type: '#{@type.to_s.classify}', got value: #{@value.inspect}."
        end
      end

      class InvalidAttributeType < Error
        def initialize(attribute, value)
          @attribute = attribute
          @value = value
        end

        def message
          "Invalid value for '#{@attribute[:name]}'! Expected value type '#{@attribute[:type]}' got value: '#{@value}'."
        end
      end

      class InvalidResourceType < Error
        def initialize(type)
          @type = type
        end

        def message
          "Invalid resource type! Resource called '#{@type}' has been not found in current API."
        end
      end

      class InvalidPayload < Error
        def initialize(message)
          @message = message
        end

        attr_reader :message
      end
    end
  end
end
