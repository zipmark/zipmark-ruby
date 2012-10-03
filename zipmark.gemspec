require File.expand_path("../lib/zipmark/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'zipmark'
  s.version     = Zipmark::VERSION
  s.platform    = Gem::Platform::RUBY
  s.summary     = "Zipmark API Client Library"
  s.description = "Simple Client Library to connect to the Zipmark API"
  s.authors     = ["Jake Howerton"]
  s.email       = 'jake@zipmark.com'
  s.homepage    = 'http://rubygems.org/gems/zipmark'

  # If you need to check in files that aren't .rb files, add them here
  s.files        = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.require_path = 'lib'
end
