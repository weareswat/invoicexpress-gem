require 'invoicexpress/models'

module Invoicexpress
  class Client
    module Clients

      # List clients
      def list(options={})
        params = { :per_page => 30, :page => 1, :klass => Invoicexpress::Models::Client }

        get("clients.xml", params.merge(options))
      end

      # Create a client
      def create(client, options={})
        if !client || !client.is_a?(Invoicexpress::Models::Client)
          raise ArgumentError, "Need a Invoicexpress::Models::Client instance"
        end

        if client.name.empty?
          raise ArgumentError, "Client's name is required"
        end

        params = { :body => client, :klass => Invoicexpress::Models::Client }
        post("clients.xml", params.merge(options))
      end

    end
  end
end
