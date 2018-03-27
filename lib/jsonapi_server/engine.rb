# frozen_string_literal: true

module JSONAPI
  class Server
    class Engine < ::Rails::Engine
      isolate_namespace JSONAPI::Server

      initializer "jsonapi_server.load_api" do |app|
        Dir[app.root.join('app', 'api', '**', '*.rb')].each { |file| require file }
      end
    end
  end
end
