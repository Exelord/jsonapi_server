# frozen_string_literal: true

module JSONAPI
  class Server
    class Attributes
      @@attrs = []

      cattr_reader :attrs

      def self.attributes(*keys)
        keys.each { |key| attribute(key) }
      end

      def self.attribute(key)
        define_method(key) do
          model.send(key)
        end

        define_method("#{key}=") do |value|
          model.send("#{key}=", value)
        end

        @@attrs << { key: key.to_sym }
      end

      attr_reader :model

      def initialize(model)
        @model = model
      end

      def to_h
        attributes = {}

        self.class.attrs.each do |attr|
          attributes[attr[:key]] = send(attr[:key])
        end

        attributes
      end
    end
  end
end