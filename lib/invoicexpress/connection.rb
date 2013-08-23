require 'faraday_middleware'
require 'faraday/response/parse_xml'
require 'faraday/response/raise_invoicexpress_errors'

module Invoicexpress
  # @private
  module Connection
    private

    def connection(options={})
      klass = options.delete(:klass)

      options = {
        :raw => false,
        :ssl => { :verify => false }
      }.merge(options)

      if !proxy.nil?
        options.merge!(:proxy => proxy)
      end

      options.merge!(:params => authentication)

      connection = Faraday.new(options) do |builder|
        builder.request :url_encoded

        builder.use FaradayMiddleware::FollowRedirects
        builder.use Faraday::Response::ParseXML, klass
        builder.use Faraday::Response::RaiseInvoicexpressErrors

        faraday_config_block.call(builder) if faraday_config_block
        builder.adapter *adapter
      end

      connection.headers[:user_agent] = user_agent
      connection
    end

  end
end
