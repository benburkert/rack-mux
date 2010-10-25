require 'rack'

module Rack
  class Mux
    VERSION = '0.1.0'
    HEADER  = 'X-Mux-Uri'

    def initialize(app, options = {})
      @app, @rack_options = app, options
      @host = options[:Host] || '0.0.0.0'
      @port = options[:Port] || find_port
      @uri  = URI.parse("http://#{@host}:#{@port}")

      rackup
    end

    def call(env)
      @app.call(env.merge(HEADER => @uri.to_s))
    end

    def rackup
      Thread.new(server_options) do |options|
        Server.start(server_options)
      end

      wait_for_server
    end

    def server_options
      default_options.merge(@rack_options).merge(:app => self)
    end

    def default_options
      {
        :environment => ENV['RACK_ENV'] || "development",
        :Port        => @port,
        :Host        => @host
      }
    end

    def find_port
      port = rand(64510) + 1025

      begin
        TCPSocket.new(@host, port)
        retry
      rescue Errno::ECONNREFUSED
        return port
      end
    end

    def wait_for_server
      Timeout::timeout(30) do
        begin
          return TCPSocket.new(@host, @port)
        rescue Errno::ECONNREFUSED
          retry
        rescue => e
          raise Error, e.message
        end
      end
    end

    # http://github.com/rack/rack/commit/c73b474525bace3f059a130b15413abd4d917086
    class Server < Rack::Server
      def initialize(options = nil)
        @options = options
        @app = options[:app] if options && options[:app]
      end
    end
  end
end