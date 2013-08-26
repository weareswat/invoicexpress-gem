require 'invoicexpress/configuration'
require 'invoicexpress/error'
require 'invoicexpress/client'

module Invoicexpress
  extend Configuration

  class << self
    # Alias for Invoicexpress::Client.new
    #
    # @return [Invoicexpress::Client]
    def new(options={})
      Invoicexpress::Client.new(options)
    end

    # Delegate to Octokit::Client.new
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def respond_to?(method, include_private=false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end
