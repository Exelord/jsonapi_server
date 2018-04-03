# frozen_string_literal: true

module JSONAPI
  class Server
    class Resource
      attr_reader :model, :context

      def initialize(model = nil, context = {})
        @model = model || self.class.model_klass.new
        @context = context
      end

      def id
        model.id
      end

      def type
        self.class.resource_name
      end

      def attributes
        @attributes ||= self.class.attributes_klass.new(model, context)
      end

      def relationships
        @relationships ||= self.class.relationships_klass.new(model, context)
      end

      def destroy
        model.destroy
      end

      def save
        model.save
      end

      def assign(params)
        attributes.assign(params[:attributes])
        relationships.assign(params[:relationships])
      end

      class << self
        def all(options = {})
          JSONAPI::Server::Resources.new(self, records(options), options[:context])
        end

        def find(id, options = {})
          model = records(options).find(id)
          new(model, options[:context])
        end

        def create(params, options = {})
          resource = new(nil, options[:context])
          resource.assign(params)
          resource.save && resource
        end

        def update(id, params, options = {})
          resource = find(id, options)
          resource.assign(params)
          resource.save && resource
        end

        def destroy(id, options = {})
          find(id, options).destroy
        end

        def records(_options = {})
          model_klass.all
        end

        def model_klass
          @model_klass ||= (@model_name || namespace_module.name.demodulize.singularize).constantize
        end

        def resource_name
          @resource_name ||= namespace_module.name.demodulize
        end

        def namespace_module
          @namespace_module ||= name.deconstantize.constantize
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
