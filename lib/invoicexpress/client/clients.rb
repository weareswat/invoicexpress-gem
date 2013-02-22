require 'invoicexpress/models'

module Invoicexpress
  class Client
    module Clients

      # Returns all your clients
      #
      # @option options [Integer] per_page (30) You can specify how many results you want to fetch
      # @option options [Integer] page (1) You can ask a specific page of clients
      #
      # @return [Array<Invoicexpress::Models::Client>] An array with all your clients
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      def clients(options={})
        params = { :per_page => 30, :page => 1, :klass => Invoicexpress::Models::Client }

        get("clients.xml", params.merge(options))
      end

      # Creates a new client.
      #
      # @param client [Invoicexpress::Models::Client] The client to create
      # @return [Invoicexpress::Models::Client] The new client from the server
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
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

      # Updates a client.
      #
      # @param client [Invoicexpress::Models::Client] The client to update
      # @return [Invoicexpress::Models::Client] The new client from the server
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      # @raise Invoicexpress::NotFound When the Client's ID is not found
      def update_client(client, options={})
        if !client || !client.is_a?(Invoicexpress::Models::Client)
          raise ArgumentError, "Need a Invoicexpress::Models::Client instance"
        end

        if !client.id
          raise ArgumentError, "Client's ID is required"
        end

        params = { :body => client, :klass => Invoicexpress::Models::Client }
        put("clients/#{client.id.to_s}.xml", params.merge(options))
      end

      # Returns a specific client
      #
      # @param client_id [String] The client's ID
      # @return [Invoicexpress::Models::Client] The remote client from the server
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      # @raise Invoicexpress::NotFound When the client ID is not found
      def client(client_id, options={})
        params = { :klass => Invoicexpress::Models::Client }

        get("clients/#{client_id.to_s}.xml", params.merge(options))
      end

      # This method allows you to obtain the invoices for a specific client.
      # Allowing filtering aswell.
      #
      # @param client_id [String] The client's ID
      # @param filter [Invoicexpress::Models::Filter] An optional filter
      # @option options [Integer] per_page (10) You can specify how many results you want to fetch
      # @option options [Integer] page (1) You can ask a specific page of clients
      # @return [Invoicexpress::Models::ClientInvoices] The invoices result
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::NotFound When the client ID is not found
      def client_invoices(client_id, filter=Invoicexpress::Models::Filter.new, options={})
        raise(ArgumentError, "filter has the wrong type") unless filter.is_a?(Invoicexpress::Models::Filter)

        params = {
          :klass    => Invoicexpress::Models::ClientInvoices,
          :per_page => 10,
          :page     => 1,
          :body     => filter
        }

        post("clients/#{client_id.to_s}/invoices.xml", params.merge(options))
      end

      # Use this method to obtain a client by name. Partial searches are not supported
      #
      # @param client_name [String] The client's name
      # @return [Invoicexpress::Models::Client] The client
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::NotFound When there are no clients with that name
      def client_by_name(client_name, options={})
        params = {
          :klass       => Invoicexpress::Models::Client,
          :client_name => client_name
        }

        get("clients/find-by-name.xml", params.merge(options))
      end

      # Use this method to obtain a client by your code. Partial searches are not supported
      #
      # @param client_code [String] The client's code (your code)
      # @return [Invoicexpress::Models::Client] The client
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::NotFound When there are no clients with that name
      def client_by_code(client_code, options={})
        params = {
          :klass       => Invoicexpress::Models::Client,
          :client_code => client_code
        }

        get("clients/find-by-code.xml", params.merge(options))
      end

      # This method allows you to create a new invoice for a specific client.
      # When creating the invoice:
      # - If items do not exist with the given names, new ones will be created.
      # - If item name already exists, the item is updated with the new values.
      # Regarding item taxes, if the tax name is not found, no tax is applied to that item.
      #
      # @param client_id [String] The ID of the client
      # @return [Invoicexpress::Models::Invoice] The invoice
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      # @raise Invoicexpress::NotFound When there are no clients with that name
      def client_create_invoice(client_id, invoice, options={})
        raise(ArgumentError, "invoice has the wrong type") unless invoice.is_a?(Invoicexpress::Models::Invoice)

        params = {
          :klass => Invoicexpress::Models::Invoice,
          :body  => invoice
        }

        post("clients/#{client_id}/create/invoice.xml", params.merge(options))
      end
      
      # This method allows you to create a new cash invoice for a specific client.
      # When creating the invoice:
      # - If items do not exist with the given names, new ones will be created.
      # - If item name already exists, the item is updated with the new values.
      # Regarding item taxes, if the tax name is not found, no tax is applied to that item.
      #
      # @param client_id [String] The ID of the client
      # @return [Invoicexpress::Models::CashInvoice] The invoice
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      # @raise Invoicexpress::NotFound When there are no clients with that name
      def client_create_cash_invoice(client_id, invoice, options={})
        raise(ArgumentError, "invoice has the wrong type") unless invoice.is_a?(Invoicexpress::Models::CashInvoice)

        params = {
          :klass => Invoicexpress::Models::CashInvoice,
          :body  => invoice
        }

        post("clients/#{client_id}/create/cash-invoice.xml", params.merge(options))
      end
      
      # This method allows you to create a new Credit Note for a specific client.
      # When creating the invoice:
      # - If items do not exist with the given names, new ones will be created.
      # - If item name already exists, the item is updated with the new values.
      # Regarding item taxes, if the tax name is not found, no tax is applied to that item.
      #
      # @param client_id [String] The ID of the client
      # @return [Invoicexpress::Models::CreditNote] The credit note
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      # @raise Invoicexpress::NotFound When there are no clients with that name
      def client_create_credit_note(client_id, invoice, options={})
        raise(ArgumentError, "credit note has the wrong type") unless invoice.is_a?(Invoicexpress::Models::CreditNote)

        params = {
          :klass => Invoicexpress::Models::CreditNote,
          :body  => invoice
        }

        post("clients/#{client_id}/create/credit-note.xml", params.merge(options))
      end

      # This method allows you to create a new Debit Note for a specific client.
      # When creating the invoice:
      # - If items do not exist with the given names, new ones will be created.
      # - If item name already exists, the item is updated with the new values.
      # Regarding item taxes, if the tax name is not found, no tax is applied to that item.
      #
      # @param client_id [String] The ID of the client
      # @return [Invoicexpress::Models::DebitNote] The debit note
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      # @raise Invoicexpress::NotFound When there are no clients with that name
      def client_create_debit_note(client_id, invoice, options={})
        raise(ArgumentError, "debit note has the wrong type") unless invoice.is_a?(Invoicexpress::Models::DebitNote)

        params = {
          :klass => Invoicexpress::Models::DebitNote,
          :body  => invoice
        }

        post("clients/#{client_id}/create/debit-note.xml", params.merge(options))
      end

    end
  end
end
