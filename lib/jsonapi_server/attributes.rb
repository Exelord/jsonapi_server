# frozen_string_literal: true

module JSONAPI
  class Server
    class Attributes
      attr_reader :model, :context

      def initialize(model, context = {})
        @model = model
        @context = context
      end

      def assign(attributes)
        # assign attributes to model through generated set methods
      end

      class << self
        attr_accessor :attrs

        def attrs
          @attrs ||= []
        end

        def attributes(*names)
          names.each { |name| attribute(name) }
        end

        def attribute(name, options = {})
          name = name.to_sym
          key = options[:key].to_sym || name
          type = options[:type]&.to_sym

          define_method(name) do
            model.send(key)
          end

          define_method("#{name}=") do |value|
            model.send("#{key}=", value)
          end

          attrs << { name: name, key: key, type: type }
        end
      end
    end
  end
end
