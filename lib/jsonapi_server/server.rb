# frozen_string_literal: true

module JSONAPI
  class Server
    attr_reader :server_options

    def initialize(options = {})
      @server_options = {
        context: {}
      }.merge(options)
    end

    def all(resource_name, options = {})
      options = server_options.merge(options)
      resource_klass = resource_klass_for_name(resource_name)

      resource_klass.all(options)
    end

    def find(resource_name, id, options = {})
      options = server_options.merge(options)
      resource_klass = resource_klass_for_name(resource_name)

      resource_klass.find(id, options)
    end

    def create(resource_name, payload = {}, options = {})
      options = server_options.merge(options)
      resource_klass = resource_klass_for_name(resource_name)
      params = deserialize_payload(resource_klass, payload)

      resource_klass.create(params, options)
    end

    def update(resource_name, id, payload = {}, options = {})
      options = server_options.merge(options)
      resource_klass = resource_klass_for_name(resource_name)
      params = deserialize_payload(resource_klass, payload)

      resource_klass.update(id, params, options)
    end

    def destroy(resource_name, id, options = {})
      options = server_options.merge(options)
      resource_klass = resource_klass_for_name(resource_name)

      resource_klass.destroy(id, options)
    end

    private

    def deserialize_payload(resource_klass, payload = {})
      JSONAPI::Server::Deserializer.new(
        types: {}, # TODO: return hash of types with mapping classes eg: { integer: JSONAPI::Server::Types::Integer }
        resources: {}, # TODO: return hash of resources with model names, eg: { user: { model_name: 'User' } }
        attributes: resource_klass.attributes,
        relationships: resource_klass.relationships
      ).deserialize(payload)
    end

    def resource_klass_for_name(resource_name)
      resource_module_for_name(resource_name)::Resource
    end

    def resource_module_for_name(resource_name)
      resource_name = resource_name.to_s.classify.pluralize
      module_name = self.class.name.deconstantize

      "#{module_name}::#{resource_name}".constantize
    end
  end
end
