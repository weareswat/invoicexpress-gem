require 'faraday'

# @api private
module Faraday
  class Response::ParseXML < Response::Middleware

    def initialize(app, klass)
      @klass = klass

      super(app)
    end
    
    def on_complete(env)
      env[:body] = @klass.parse env[:body]

      super
    end

  end
end
