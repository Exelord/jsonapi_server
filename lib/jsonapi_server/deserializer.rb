module JSONAPI
  class Server
    class Deserializer
      attr_reader :model_klass, :attributes, :relationships

      def initialize(model_klass:, attributes:, relationships:)
        @model_klass = model_klass
        @attributes = attributes
        @relationships = relationships
      end

      def deserialize(payload = {})
        validate_payload(payload)

        {
          attributes: deserialize_attributes(payload),
          relationships: deserialize_relationships(payload),
        }
      end

      private

      def validate_payload(payload)
        # validate payload format
      end

      def deserialize_attributes(payload)
        {}
      end

      def deserialize_relationships(payload)
        {}
      end
    end
  end
end