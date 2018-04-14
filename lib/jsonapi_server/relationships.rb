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
        relationships.each do |name, value|
          send("#{name}=", value)
        end
      end

      class << self
        def rels
          @rels ||= {}
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
          key = options[:key]&.to_sym || name

          define_method(name) do
            model.send(key)
          end

          define_method("#{name}=") do |value|
            if kind == :belongs_to
              reflection = model.class.reflections[key.to_s]

              model.send("#{reflection.foreign_key}=", value[:id])
            end
          end

          rels[name] = { name: name, kind: kind, key: key }
        end
      end
    end
  end
end
