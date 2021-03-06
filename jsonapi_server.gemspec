# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'jsonapi_server/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'jsonapi_server'
  s.version     = JSONAPI::Server::VERSION
  s.authors     = ['Maciej Kwaśniak']
  s.email       = ['kmaciek17@gmail.com']
  s.homepage    = ''
  s.summary     = 'Summary of JSONAPIServer.'
  s.description = 'Description of JSONAPIServer.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'jsonapi-parser', '0.1.1'
  s.add_dependency 'rails', '~> 5.1.5'

  s.add_development_dependency 'sqlite3'
end
