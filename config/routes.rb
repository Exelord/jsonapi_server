Rails.application.routes.draw do
  resources_klasses = ObjectSpace.each_object(Class).select { |klass| klass < JSONAPI::Server::Resource }

  resources_klasses.each do |klass|
    segments = klass.to_s.split('::')
    segments.pop

    segments.map { |segment| segment.camelize(:lower) }.map(&:dasherize)
  end
end
