require 'invoicexpress/models'

module Invoicexpress
  class Client
    module SimplifiedInvoices
      
      # Returns all your simplified invoices
      #
      # @option options [Integer] page (1) You can ask a specific page of simplified invoices
      #
      # @return [Invoicexpress::Models::SimplifiedInvoices] A struct with results (pagination) and all the simplified invoices
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      def simplified_invoices(options={})
        params = { :page => 1, :klass => Invoicexpress::Models::SimplifiedInvoice }

        get("simplified_invoices.xml", params.merge(options))
      end



      # Returns all the information about a simplified invoice:
      # - Basic information (date, status, sequence number)
      # - Client
      # - Document items
      # - Document timeline
      # Document timeline is composed by:
      # - Date, time and the user who created it
      # - Type of the event
      # The complete list of timeline events is:
      # - create
      # - edited
      # - send_email
      # - canceled
      # - deleted
      # - settled
      # - second_copy
      # - archived
      # - unarchived
      # - comment
      #
      # @param simplified_invoice_id [String] Requested simplified invoice id
      # @return [Invoicexpress::Models::SimplifiedInvoice] The requested simplified invoice
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::NotFound When the simplified_invoice doesn't exist
      def simplified_invoice(simplified_invoice_id, options={})
        params = { :klass => Invoicexpress::Models::SimplifiedInvoice }

        get("simplified_invoices/#{simplified_invoice_id}.xml", params.merge(options))
      end

      # Creates a new simplified invoice. Also allows to create a new client and/or new items in the same request.
      # If the client name does not exist a new one is created.
      # If items do not exist with the given names, new ones will be created.
      # If item name  already exists, the item is updated with the new values.
      # Regarding item taxes, if the tax name is not found, no tax is applyed to that item.
      # Portuguese accounts should also send the IVA exemption reason if the invoice contains exempt items(IVA 0%)
      #
      # @param simplified_invoice [Invoicexpress::Models::SimplifiedInvoice] The simplified invoice to create
      # @return [Invoicexpress::Models::SimplifiedInvoice] The created simplified invoice
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      def create_simplified_invoice(simplified_invoice, options={})
        raise(ArgumentError, "simplified invoice has the wrong type") unless simplified_invoice.is_a?(Invoicexpress::Models::SimplifiedInvoice)

        params = { :klass => Invoicexpress::Models::SimplifiedInvoice, :body  => simplified_invoice }
        post("simplified_invoices.xml", params.merge(options))
      end

      # Updates a simplified invoice
      # It also allows you to create a new client and/or items in the same request.
      # If the client name does not exist a new client is created.
      # Regarding item taxes, if the tax name is not found, no tax will be applied to that item.
      # If item does not exist with the given name, a new one will be created.
      # If item exists it will be updated with the new values
      # Be careful when updating the document items, any missing items from the original document will be deleted.
      #
      # @param simplified_invoice [Invoicexpress::Models::SimplifiedInvoice] The cash simplified invoice to update
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      # @raise Invoicexpress::NotFound When the simplified invoice doesn't exist
      def update_simplified_invoice(simplified_invoice, options={})
        raise(ArgumentError, "simplified invoice has the wrong type") unless simplified_invoice.is_a?(Invoicexpress::Models::SimplifiedInvoice)

        params = { :klass => Invoicexpress::Models::SimplifiedInvoice, :body => simplified_invoice.to_core() }
        put("simplified_invoices/#{simplified_invoice.id}.xml", params.merge(options))
      end

      # Changes the state of a simplified invoice.
      # Possible state transitions:
      # - draft to final – finalized
      # - draft to deleted – deleted
      # - settled to final – unsettled
      # - final to second copy – second_copy
      # - final or second copy to canceled – canceled
      # - final or second copy to settled – settled
      # Any other transitions will fail.
      # When canceling a simplified invoice you must specify a reason.
      #
      # @param simplified_invoice_id [String] The simplified invoice id to change
      # @param simplified_invoice_state [Invoicexpress::Models::InvoiceState] The new state
      # @return [Invoicexpress::Models::SimplifiedInvoice] The updated simplified invoice
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      # @raise Invoicexpress::NotFound When the simplified invoice doesn't exist
      def update_simplified_invoice_state(simplified_invoice_id, simplified_invoice_state, options={})
        raise(ArgumentError, "simplified invoice state has the wrong type") unless simplified_invoice_state.is_a?(Invoicexpress::Models::InvoiceState)

        params = { :klass => Invoicexpress::Models::SimplifiedInvoice, :body => simplified_invoice_state }
        put("simplified_invoices/#{simplified_invoice_id}/change-state.xml", params.merge(options))
      end

      # Sends the simplified invoice through email
      #
      # @param simplified_invoice_id [String] The simplified invoice id to send
      # @param message [Invoicexpress::Models::Message] The message to send
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      # @raise Invoicexpress::NotFound When the simplified invoice doesn't exist
      def simplified_invoice_mail(simplified_invoice_id, message, options={})
        raise(ArgumentError, "message has the wrong type") unless message.is_a?(Invoicexpress::Models::Message)

        params = { :body => message, :klass => Invoicexpress::Models::SimplifiedInvoice }
        put("simplified_invoices/#{simplified_invoice_id}/email-document.xml", params.merge(options))
      end

    end
  end
end
