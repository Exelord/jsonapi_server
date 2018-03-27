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
      models = resource_klass.records(options)

      JSONAPI::Server::Resources.new(resource_klass, models, options[:context])
    end

    def find(resource_name, id, options = {})
      options = server_options.merge(options)

      resource_klass = resource_klass_for_name(resource_name)
      model = resource_klass.records(options[:context]).find(id)

      resource_klass.new(model, options[:context])
    end

    def destroy
      policy
      resource.destroy
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

# def index
#   render jsonapi: api_server.all('users', options)
# end
#
# def show
  # render jsonapi: api_server.find('users', id, options)
# end
#
# def create
#   render jsonapi: api_server.create('users', payload, options)
# end
#
# def update
#   render jsonapi: api_server.update('users', id, payload, options)
# end
#
# def destroy
#   render jsonapi: api_server.destroy('users', id, options)
# end