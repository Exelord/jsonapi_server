module JSONAPI
  class Server
    class Resources
      attr_reader :resource_klass, :models, :context

      def initialize(resource_klass, models, context = {})
        @resource_klass = resource_klass
        @models = models
        @context = context
      end

      def resources
        @resources ||= models.map { |model| resource_klass.new(model) }
      end
    end
  end
end