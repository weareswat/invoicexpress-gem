require 'faraday'
require 'pry'

# @api private
module Faraday
  class Response::ParseXML < Response::Middleware

    def initialize(app, klass)
      @klass = klass

      super(app)
    end
    
    def on_complete(env)
      if env[:body] and !env[:body].strip.empty?
        env[:body] = @klass.parse env[:body]
      else
        env[:body] = nil
      end
    end

  end
end
