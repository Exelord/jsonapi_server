# frozen_string_literal: true

module JSONAPI
  class Server
    class Relationships
      @@rels = []

      cattr_reader :rels

      def self.has_many(key)
        relationship(:has_many, key)
      end

      def self.belongs_to(key)
        relationship(:belongs_to, key)
      end

      def self.relationship(kind, key)
        define_method(key) do
          model.send(key)
        end

        define_method("#{key}=") do |value|
          model.send("#{key}=", value)
        end

        @@rels << { kind: kind, key: key.to_sym }
      end

      attr_reader :model

      def initialize(model)
        @model = model
      end
    end
  end
end