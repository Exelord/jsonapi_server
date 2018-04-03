# frozen_string_literal: true

Rails.application.routes.draw do
  resources_klasses = ObjectSpace.each_object(Class).select { |klass| klass < JSONAPI::Server::Resource }

  resources_klasses.each do |klass|
    segments = klass.to_s.split('::').tap do |elements|
      elements.pop
      elements.map! { |element| element.camelize(:lower) }
    end

    path = segments.map(&:dasherize).join('/')
    controller = segments.map(&:underscore).join('/')

    match path, controller: controller, action: :index, via: :get
  end
end
