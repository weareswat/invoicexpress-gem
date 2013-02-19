require 'multi_json'

module Invoicexpress
  module Request
    def delete(path, options={})
      request(:delete, path, options).body
    end

    def get(path, options={})
      repsonse = request(:get, path, options).body
    end

    def patch(path, options={})
      request(:patch, path, options).body
    end

    def post(path, options={})
      request(:post, path, options).body
    end

    def put(path, options={})
      request(:put, path, options).body
    end

    private
    
    # Executes the request, checking if ti was successful
    #
    # @return [Boolean] True on success, false otherwise
    def boolean_from_response(method, path, options={})
      request(method, path, options).status == 204
    rescue Invoicexpress::NotFound
      false
    end

    def request(method, path, options={})
      token = options.delete(:api_token) || api_token

      force_urlencoded = options.delete(:force_urlencoded) || false
      url = options.delete(:endpoint) || (api_endpoint % screen_name)

      conn_options = {
        :force_urlencoded => force_urlencoded,
        :url              => url
      }

      response = connection(conn_options).send(method) do |request|
        request.headers['Accept'] = options.delete(:accept) || 'application/json'

        case method
        when :get, :delete, :head
          request.url(path, options)
        when :patch, :post, :put
          request.path = path
          if force_urlencoded
            request.body = options unless options.empty?
          else
            request.body = MultiJson.dump(options) unless options.empty?
          end
        end

      end

      response
    end

  end
end
