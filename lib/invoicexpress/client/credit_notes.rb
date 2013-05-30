require 'invoicexpress/models'

module Invoicexpress
  class Client
    module CreditNotes
      
      # Returns all your credit notes
      #
      # @option options [Integer] page (1) You can ask a specific page of credit notes
      #
      # @return [Invoicexpress::Models::CreditNotes] A struct with results (pagination) and all the credit notes
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      def credit_notes(options={})
        params = { :page => 1, :klass => Invoicexpress::Models::CreditNote }

        get("credit_notes.xml", params.merge(options))
      end

      # Returns all the information about a credit note:
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
      # @param credit_note_id [String] Requested credit note id
      # @return [Invoicexpress::Models::CreditNote] The requested credit note
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::NotFound When the credit_note doesn't exist
      def credit_note(credit_note_id, options={})
        params = { :klass => Invoicexpress::Models::CreditNote }

        get("credit_notes/#{credit_note_id}.xml", params.merge(options))
      end

      # Creates a new credit note. Also allows to create a new client and/or new items in the same request.
      # If the client name does not exist a new one is created.
      # If items do not exist with the given names, new ones will be created.
      # If item name  already exists, the item is updated with the new values.
      # Regarding item taxes, if the tax name is not found, no tax is applyed to that item.
      # Portuguese accounts should also send the IVA exemption reason if the invoice contains exempt items(IVA 0%)
      #
      # @param credit_note [Invoicexpress::Models::CreditNote] The credit note to create
      # @return [Invoicexpress::Models::CreditNote] The created credit note
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      def create_credit_note(credit_note, options={})
        raise(ArgumentError, "credit note has the wrong type") unless credit_note.is_a?(Invoicexpress::Models::CreditNote)

        params = { :klass => Invoicexpress::Models::CreditNote, :body  => credit_note }
        post("credit_notes.xml", params.merge(options))
      end

      # Updates a credit note
      # It also allows you to create a new client and/or items in the same request.
      # If the client name does not exist a new client is created.
      # Regarding item taxes, if the tax name is not found, no tax will be applied to that item.
      # If item does not exist with the given name, a new one will be created.
      # If item exists it will be updated with the new values
      # Be careful when updating the document items, any missing items from the original document will be deleted.
      #
      # @param credit_note [Invoicexpress::Models::CreditNote] The credit note to update
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      # @raise Invoicexpress::NotFound When the credit note doesn't exist
      def update_credit_note(credit_note, options={})
        raise(ArgumentError, "credit note has the wrong type") unless credit_note.is_a?(Invoicexpress::Models::CreditNote)

        params = { :klass => Invoicexpress::Models::CreditNote, :body => credit_note }
        put("credit_notes/#{credit_note.id}.xml", params.merge(options))
      end

      # Changes the state of a credit note.
      # Possible state transitions:
      # - draft to final – finalized
      # - draft to deleted – deleted
      # - settled to final – unsettled
      # - final to second copy – second_copy
      # - final or second copy to canceled – canceled
      # - final or second copy to settled – settled
      # Any other transitions will fail.
      # When canceling a credit note you must specify a reason.
      #
      # @param credit_note_id [String] The credit note id to change
      # @param credit_note_state [Invoicexpress::Models::InvoiceState] The new state
      # @return [Invoicexpress::Models::CreditNote] The updated credit note
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      # @raise Invoicexpress::NotFound When the credit note doesn't exist
      def update_credit_note_state(credit_note_id, credit_note_state, options={})
        raise(ArgumentError, "credit note state has the wrong type") unless credit_note_state.is_a?(Invoicexpress::Models::InvoiceState)

        params = { :klass => Invoicexpress::Models::CreditNote, :body => credit_note_state }
        put("credit_notes/#{credit_note_id}/change-state.xml", params.merge(options))
      end

      # Sends the credit note through email
      #
      # @param credit_note_id [String] The credit note id to send
      # @param message [Invoicexpress::Models::Message] The message to send
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      # @raise Invoicexpress::NotFound When the credit note doesn't exist
      def credit_note_mail(credit_note_id, message, options={})
        raise(ArgumentError, "message has the wrong type") unless message.is_a?(Invoicexpress::Models::Message)

        params = { :body => message, :klass => Invoicexpress::Models::CreditNote }
        put("credit_notes/#{credit_note_id}/email-document.xml", params.merge(options))
      end

    end
  end
end
