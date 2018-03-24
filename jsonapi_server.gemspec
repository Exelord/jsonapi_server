$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "jsonapi_server/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "jsonapi_server"
  s.version     = JsonapiServer::VERSION
  s.authors     = ["Maciej Kwaśniak"]
  s.email       = ["kmaciek17@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of JsonapiServer."
  s.description = "TODO: Description of JsonapiServer."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.5"

  s.add_development_dependency "sqlite3"
end
