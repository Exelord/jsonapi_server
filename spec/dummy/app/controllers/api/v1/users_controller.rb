# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  def index
    render json: api_server.all('users', options).serialize(serializer_options)
  end

  def show
    render json: api_server.find('users', id, options).serialize(serializer_options)
  end

  def create
    render json: api_server.create('users', payload, options).serialize(serializer_options)
  end

  def update
    render json: api_server.update('users', id, payload, options).serialize(serializer_options)
  end

  def destroy
    render json: api_server.destroy('users', id, options).serialize(serializer_options)
  end

  private

  def api_server
    @api_server ||= Api::V1::Server.new(server_options)
  end

  def context
    @context ||= {}
  end

  def options
    @options ||= {}
  end

  def serializer_options
    @serializer_options ||= {}
  end

  def server_options
    @server_options ||= { context: context }
  end
end
