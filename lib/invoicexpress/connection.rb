require 'faraday_middleware'

module Invoicexpress
  # @private
  module Connection
    private

    def connection(options={})
      options = {
        :force_urlencoded => false,
        :raw              => false,
        :ssl              => { :verify => false }
      }.merge(options)

      if !proxy.nil?
        options.merge!(:proxy => proxy)
      end

      options.merge!(:params => authentication)

      connection = Faraday.new(options) do |builder|
        if options[:force_urlencoded]
          builder.request :url_encoded
        else
          builder.request :json
        end

        builder.use FaradayMiddleware::FollowRedirects
        builder.use FaradayMiddleware::Mashify
        builder.use FaradayMiddleware::ParseJson, :content_type => /\bjson$/

        faraday_config_block.call(builder) if faraday_config_block
        builder.adapter *adapter
      end

      connection.headers[:user_agent] = user_agent
      connection
    end

  end
end
