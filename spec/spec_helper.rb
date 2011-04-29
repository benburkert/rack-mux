$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'timeout'
require 'rack/mux'
require 'rack/client'
require 'json'
require 'mongrel'

RSpec.configure do |config|
  config.color_enabled = true

  config.before(:all) do
    @client = Rack::Client.new do
      use Rack::Lint
      use Rack::Mux
      use Rack::Lint
      run lambda {|env| [200, {'Content-Type' => 'application/json'}, [env.to_json]] }
    end
  end
end
