require 'invoicexpress/models'

module Invoicexpress
  class Client
    module Clients

      # Returns all your clients
      #
      # @param options.per_page [Integer] You can specify how many results you want to fetch
      # @param options.page [Integer] You can ask a specific page of clients
      # @return [Array of Invoicexpress::Model::Client] An array with all your clients
      def clients(options={})
        params = { :per_page => 30, :page => 1, :klass => Invoicexpress::Models::Client }

        get("clients.xml", params.merge(options))
      end

      # Creates a new client.
      #
      # @param client [Invoicexpress::Models::Client] The client to create
      # @return [Invoicexpress::Models::Client] The new client from the server
      def create_client(client, options={})
        if !client || !client.is_a?(Invoicexpress::Models::Client)
          raise ArgumentError, "Need a Invoicexpress::Models::Client instance"
        end

        if !client.name
          raise ArgumentError, "Client's name is required"
        end

        params = { :body => client, :klass => Invoicexpress::Models::Client }
        post("clients.xml", params.merge(options))
      end

      # Returns a specific client
      #
      # @param client_id [String] The client's ID
      # @return [Invoicexpress::models::Client] The remote client from the server
      def client(client_id, options={})
        params = { :klass => Invoicexpress::Models::Client }

        get("clients/#{client_id.to_s}.xml", params.merge(options))
      end

    end
  end
end
