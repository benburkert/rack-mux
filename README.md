rack-mux
===========

Multiplex multiple rack servers to the same app.

example
-------

config.ru

    require 'rack/mux'

    use Rack::Mux
    run lambda {|env| [200, {'Content-Type' => 'text/plain'}, [env['X-Mux-Uri']]] }

rackup

    % rackup config.ru -p 9292

irb

    >> require 'rack/client'
    => true
    >> uri = Rack::Client.new("http://localhost:9292/").get("/").body
    => 'http://0.0.0.0:4000'
    >> Rack::Client.new(uri).get('/').status
    => 200
