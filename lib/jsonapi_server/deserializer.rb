# frozen_string_literal: true

require 'jsonapi/parser'

module JSONAPI
  class Server
    class Deserializer
      attr_reader :resources, :attributes, :relationships, :types

      def initialize(attributes: {}, relationships: {}, resources: {}, types: {})
        @types = types
        @resources = resources
        @attributes = attributes
        @relationships = relationships
      end

      def deserialize(payload = {})
        validate_payload(payload)
        normalize_payload(payload)

        {
          id: deserialize_resource_id(payload[:data][:id]),
          type: deserialize_resource_type(payload[:data][:type]),
          attributes: deserialize_attributes(payload),
          relationships: deserialize_relationships(payload)
        }
      end

      def deserialize_relationship(payload = {})
        validate_relationship_payload(payload)
        normalize_payload(payload)
        deserialize_resource(payload[:data])
      end

      private

      def validate_payload(payload)
        JSONAPI.parse_resource!(payload.deep_transform_keys { |key| key.to_s.dasherize })
      rescue JSONAPI::Parser::InvalidDocument => e
        raise(Exceptions::InvalidPayload, e.message)
      end

      def validate_relationship_payload(payload)
        JSONAPI.parse_relationship!(payload.deep_transform_keys { |key| key.to_s.dasherize })
      rescue JSONAPI::Parser::InvalidDocument => e
        raise(Exceptions::InvalidPayload, e.message)
      end

      def normalize_payload(payload = {})
        payload.deep_transform_keys! { |key| key.to_s.underscore.to_sym }
      end

      def deserialize_resource_id(id)
        type_for(:integer).deserialize(id)
      end

      def deserialize_resource_type(type)
        type = type.to_s.singularize

        model_type = resources.fetch(type.underscore.to_sym, {}).fetch(:model_name, nil)
        model_type || raise(Exceptions::InvalidResourceType, type)
      end

      def deserialize_attributes(payload)
        {}.tap do |attrs|
          payload[:data].fetch(:attributes, {}).each do |name, value|
            attribute = attributes[name]
            next if attribute.nil?

            attrs[name] = deserialize_attribute(attribute, value)
          end
        end
      end

      def deserialize_attribute(attribute, value)
        type_for(attribute[:type]).deserialize(value)
      end

      def type_for(type)
        types.fetch(type, JSONAPI::Server::Types::Type).new
      end

      def deserialize_relationships(payload)
        {}.tap do |rels|
          payload[:data].fetch(:relationships, {}).each do |name, value|
            next if relationships[name].nil?
            data = value[:data]

            rels[name] = if data.is_a?(Array)
                           data.map { |relationship| deserialize_resource(relationship) }
                         else
                           deserialize_relationship(data)
                         end
          end
        end
      end

      def deserialize_resource(data)
        { id: deserialize_resource_id(data[:id]), type: deserialize_resource_type(data[:type]) }
      end

      def invalid_attribute_type(attribute, value)
        raise(Exceptions::InvalidAttributeType.new(attribute, value))
      end
    end
  end
end
