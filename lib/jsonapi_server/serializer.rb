module JSONAPI
  class Server
    class Serializer
      attr_reader :resource

      def initialize(resource)
        @resource = resource
      end

      def id
        @id ||= resource.id.to_s
      end

      def type
        @type ||= resource.type.pluralize.camelize(:lower).dasherize
      end

      def attributes
        @attributes ||= serialize_attributes
      end

      def serialize
        {
          id: id,
          type: type,
          attributes: attributes
        }
      end

      private

      def serialize_attributes
        resource.attributes.to_h
      end
    end
  end
end