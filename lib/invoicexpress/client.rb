require 'invoicexpress/authentication'
require 'invoicexpress/connection'
require 'invoicexpress/request'

require 'invoicexpress/models'

require 'invoicexpress/client/clients'

module Invoicexpress
  class Client
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    def initialize(options={})
      options = Invoicexpress.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    include Invoicexpress::Authentication
    include Invoicexpress::Connection
    include Invoicexpress::Request

    include Invoicexpress::Client::Clients
  end
end
