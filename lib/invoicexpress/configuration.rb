require 'faraday'
require 'invoicexpress/version'

module Invoicexpress
  module Configuration
    VALID_OPTIONS_KEYS = [
      :adapter,
      :faraday_config_block,
      :api_endpoint,
      :screen_name,
      :proxy,
      :api_key,
      :user_agent
    ].freeze

    DEFAULT_ADAPTER = Faraday.default_adapter
    DEFAULT_API_ENDPOINT = ENV['INVOICEXPRESS_API_ENDPOINT'] || 'https://%s.invoicexpress.net/'
    DEFAULT_USER_AGENT = "Invoicexpress Ruby Gem #{Invoicexpress::VERSION}".freeze

    attr_accessor(*VALID_OPTIONS_KEYS)

    def self.extended(base)
      base.reset
    end
    
    def configure
      yield self
    end

    def options
      VALID_OPTIONS_KEYS.inject({}) { |o,k| o.merge!(k => send(k)) }
    end

    def api_endpoint=(value)
      @api_endpoint = File.join(value, "")
    end

    def faraday_config(&block)
      @faraday_config_block = block
    end

    def reset
      self.adapter      = DEFAULT_ADAPTER
      self.api_endpoint = DEFAULT_API_ENDPOINT
      self.user_agent   = DEFAULT_USER_AGENT
      self.api_key      = nil
      self.screen_name  = nil
      self.proxy        = nil
    end
  end
end
