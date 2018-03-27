module JSONAPI
  class Server
    class Resource
      attr_reader :model, :context

      def initialize(model, context = {})
        @model = model
        @context = context
      end

      def id
        model.id
      end

      def type
        self.class.resource_name
      end

      def attributes
        @attributes ||= self.class.attributes_klass.new(model)
      end

      def relationships
        @relationships ||= self.class.relationships_klass.new(model)
      end

      class << self
        def records(options = {})
          model_klass.all
        end

        def resource_name
          @resource_name ||= namespace_module.name.demodulize
        end

        def model_klass
          @model_klass ||= (@model_name || namespace_module.name.demodulize.singularize).constantize
        end

        def namespace_module
          @namespace_module ||= self.name.deconstantize.constantize
        end

        def attributes_klass
          @attributes_klass ||= namespace_module::Attributes
        end

        def relationships_klass
          @relationships_klass ||= namespace_module::Relationships
        end

        protected

        def model_name(name)
          @model_name ||= name.to_s.classify
        end
      end
    end
  end
end