dir = File.dirname(__FILE__)
$:.unshift dir + '/lib'

require 'rack/mux'

Gem::Specification.new do |s|
  s.name        = 'rack-mux'
  s.version     = Rack::Mux::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Ben Burkert']
  s.email       = ['ben@benburkert.com']
  s.homepage    = 'http://github.com/benburkert/rack-mux'
  s.summary     = "Multiplex multiple rack servers to the same app."
  s.description = s.summary

  s.add_dependency 'rack'

  s.add_development_dependency 'rack-client', '>=0.3.1.pre.c'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'json'
  s.add_development_dependency 'mongrel'
  s.add_development_dependency 'ruby-debug'

  s.files         = Dir["#{dir}/lib/**/*.rb"]
  s.require_paths = ["lib"]

  s.test_files    = Dir["#{dir}/spec/**/*.rb"]
end
