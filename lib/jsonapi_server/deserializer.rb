module JSONAPI
  class Server
    class Deserializer
      attr_reader :resource_klass, :payload, :relationships_klass, :attributes_klass

      def initialize(resource_klass, payload = {})
        @resource_klass = resource_klass
        @payload = payload.deep_transform_keys(&:to_sym)
        @attributes_klass = resource_klass.attributes_klass
        @relationships_klass = resource_klass.relationships_klass
      end

      def id
        @id ||= payload[:id].to_i
      end

      def type
        @id ||= payload[:type]
      end

      def attributes
        @attributes ||= deserialize_attributes
      end

      def relationships
        @attributes ||= deserialize_relationships
      end

      private

      def deserialize_attributes
        attrs_keys = attributes_klass.attrs.map { |attr| attr[:key] }
        attributes = payload[:attributes] || {}
        attributes.select { |key| attrs_keys.include?(key) }
      end

      def deserialize_relationships
        #code
      end
    end
  end
end