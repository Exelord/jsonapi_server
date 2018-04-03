# frozen_string_literal: true

module JSONAPI
  class Server
    class Relationships
      attr_reader :model, :context

      def initialize(model, context = {})
        @model = model
        @context = context
      end

      def assign(relationships)
        # assign relationships to model through generated set methods
      end

      class << self
        attr_accessor :rels

        def rels
          @rels ||= []
        end

        def has_many(name, options = {})
          relationship(:has_many, name, options)
        end

        def belongs_to(name, options = {})
          relationship(:belongs_to, name, options)
        end

        def has_one(name, options = {})
          relationship(:has_one, name, options)
        end

        def relationship(kind, name, options = {})
          kind = kind.to_sym
          name = name.to_sym
          key = options[:key].to_sym || name

          define_method(name) do
            model.send(key)
          end

          define_method("#{name}=") do |value|
            model.send("#{key}=", value)
          end

          rels << { kind: kind, name: name, key: key }
        end
      end
    end
  end
end
