require 'invoicexpress/models'

module Invoicexpress
  class Client
    module CashInvoices
      
      # Returns all your cash invoices
      #
      # @option options [Integer] page (1) You can ask a specific page of invoices
      # @return [Invoicexpress::Models::CashInvoices] A structure with results (pagination) and all the cash invoices
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      def cash_invoices(options={})
        params = { :page => 1, :klass => Invoicexpress::Models::CashInvoices }

        get("cash_invoices.xml", params.merge(options))
      end

      # Returns a specific cash invoice
      #
      # @param invoice_id [String] Requested invoice id
      # @return [Invoicexpress::Models::CashInvoice] The requested cash invoice
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::NotFound When the invoice doesn't exist
      def cash_invoice(invoice_id, options={})
        params = { :klass => Invoicexpress::Models::CashInvoice }

        get("cash_invoices/#{invoice_id}.xml", params.merge(options))
      end

      # Creates a new cash invoice. Also allows to create a new client and/or new items in the same request.
      # If the client name does not exist a new one is created.
      # If items do not exist with the given names, new ones will be created.
      # If item name  already exists, the item is updated with the new values.
      # Regarding item taxes, if the tax name is not found, no tax is applyed to that item.
      # Portuguese accounts should also send the IVA exemption reason if the invoice contains exempt items(IVA 0%)
      #
      # @param invoice [Invoicexpress::Models::CashInvoice] The cash invoice to create
      # @return [Invoicexpress::Models::CashInvoice] The created cash invoice
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      def create_cash_invoice(invoice, options={})
        raise(ArgumentError, "cash invoice has the wrong type") unless invoice.is_a?(Invoicexpress::Models::CashInvoice)

        params = { :klass => Invoicexpress::Models::CashInvoice, :body  => invoice }
        post("cash_invoices.xml", params.merge(options))
      end

      # Updates a cash invoice
      # It also allows you to create a new client and/or items in the same request.
      # If the client name does not exist a new client is created.
      # Regarding item taxes, if the tax name is not found, no tax will be applied to that item.
      # If item does not exist with the given name, a new one will be created.
      # If item exists it will be updated with the new values
      # Be careful when updating the document items, any missing items from the original document will be deleted.
      #
      # @param invoice [Invoicexpress::Models::CashInvoice] The cash invoice to update
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      # @raise Invoicexpress::NotFound When the invoice doesn't exist
      def update_cash_invoice(invoice, options={})
        raise(ArgumentError, "cash invoice has the wrong type") unless invoice.is_a?(Invoicexpress::Models::CashInvoice)

        params = { :klass => Invoicexpress::Models::CashInvoice, :body  => invoice }
        put("cash_invoices/#{invoice.id}.xml", params.merge(options))
      end

      # Changes the state of a cash invoice.
      # Possible state transitions:
      # - draft to settle – finalized
      # - draft to deleted – deleted
      # - settled to final – unsettled
      # - final to second copy – second_copy
      # - final or second copy to canceled – canceled
      # - final or second copy to settled – settled
      # Any other transitions will fail.
      # When canceling a cash invoice you must specify a reason.
      #
      # @param invoice_id [String] The cash invoice id to change
      # @param invoice_state [Invoicexpress::Models::InvoiceState] The new state
      # @return [Invoicexpress::Models::CashInvoice] The updated cash invoice
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      # @raise Invoicexpress::NotFound When the invoice doesn't exist
      def update_cash_invoice_state(invoice_id, invoice_state, options={})
        raise(ArgumentError, "invoice_state has the wrong type") unless invoice_state.is_a?(Invoicexpress::Models::InvoiceState)

        params = { :klass => Invoicexpress::Models::CashInvoice, :body => invoice_state }
        put("cash_invoices/#{invoice_id}/change-state.xml", params.merge(options))
      end

      # Sends the invoice by email
      #
      # @param invoice_id [String] The cash invoice id to change
      # @param message [Invoicexpress::Models::Message] The message to send
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      # @raise Invoicexpress::NotFound When the invoice doesn't exist
      def invoice_email(invoice_id, message, options={})
        raise(ArgumentError, "message has the wrong type") unless message.is_a?(Invoicexpress::Models::Message)

        params = { :body => message, :klass => Invoicexpress::Models::CashInvoice }
        put("cash_invoices/#{invoice_id}/email-document.xml", params.merge(options))
      end

    end
  end
end
