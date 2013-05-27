require 'invoicexpress/models'

module Invoicexpress
  class Client
    module DebitNotes
      
      # Returns all your debit notes
      #
      # @option options [Integer] page (1) You can ask a specific page of debit notes
      #
      # @return [Invoicexpress::Models::DebitNotes] A struct with results (pagination) and all the debit notes
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      def debit_notes(options={})
        params = { :page => 1, :klass => Invoicexpress::Models::DebitNote }

        get("debit_notes.xml", params.merge(options))
      end

      # Returns all the information about a debit note:
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
      # @param debit_note_id [String] Requested debit note id
      # @return [Invoicexpress::Models::DebitNote] The requested debit note
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::NotFound When the debit_note doesn't exist
      def debit_note(debit_note_id, options={})
        params = { :klass => Invoicexpress::Models::DebitNote }

        get("debit_notes/#{debit_note_id}.xml", params.merge(options))
      end

      # Creates a new debit note. Also allows to create a new client and/or new items in the same request.
      # If the client name does not exist a new one is created.
      # If items do not exist with the given names, new ones will be created.
      # If item name  already exists, the item is updated with the new values.
      # Regarding item taxes, if the tax name is not found, no tax is applyed to that item.
      # Portuguese accounts should also send the IVA exemption reason if the invoice contains exempt items(IVA 0%)
      #
      # @param debit_note [Invoicexpress::Models::DebitNote] The debit note to create
      # @return [Invoicexpress::Models::DebitNote] The created debit note
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      def create_debit_note(debit_note, options={})
        raise(ArgumentError, "debit note has the wrong type") unless debit_note.is_a?(Invoicexpress::Models::DebitNote)

        params = { :klass => Invoicexpress::Models::DebitNote, :body  => debit_note }
        post("debit_notes.xml", params.merge(options))
      end

      # Updates a debit note
      # It also allows you to create a new client and/or items in the same request.
      # If the client name does not exist a new client is created.
      # Regarding item taxes, if the tax name is not found, no tax will be applied to that item.
      # If item does not exist with the given name, a new one will be created.
      # If item exists it will be updated with the new values
      # Be careful when updating the document items, any missing items from the original document will be deleted.
      #
      # @param debit_note [Invoicexpress::Models::DebitNote] The cash debit note to update
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      # @raise Invoicexpress::NotFound When the debit note doesn't exist
      def update_debit_note(debit_note, options={})
        raise(ArgumentError, "debit note has the wrong type") unless debit_note.is_a?(Invoicexpress::Models::DebitNote)

        params = { :klass => Invoicexpress::Models::DebitNote, :body => debit_note }
        put("debit_notes/#{debit_note.id}.xml", params.merge(options))
      end

      # Changes the state of a debit note.
      # Possible state transitions:
      # - draft to final – finalized
      # - draft to deleted – deleted
      # - settled to final – unsettled
      # - final to second copy – second_copy
      # - final or second copy to canceled – canceled
      # - final or second copy to settled – settled
      # Any other transitions will fail.
      # When canceling a debit note you must specify a reason.
      #
      # @param debit_note_id [String] The debit note id to change
      # @param debit_note_state [Invoicexpress::Models::InvoiceState] The new state
      # @return [Invoicexpress::Models::DebitNote] The updated debit note
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      # @raise Invoicexpress::NotFound When the debit note doesn't exist
      def update_debit_note_state(debit_note_id, debit_note_state, options={})
        raise(ArgumentError, "debit note state has the wrong type") unless debit_note_state.is_a?(Invoicexpress::Models::InvoiceState)

        params = { :klass => Invoicexpress::Models::DebitNote, :body => debit_note_state }
        put("debit_notes/#{debit_note_id}/change-state.xml", params.merge(options))
      end

      # Sends the debit note through email
      #
      # @param debit_note_id [String] The debit note id to send
      # @param message [Invoicexpress::Models::Message] The message to send
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      # @raise Invoicexpress::NotFound When the debit note doesn't exist
      def debit_note_mail(debit_note_id, message, options={})
        raise(ArgumentError, "message has the wrong type") unless message.is_a?(Invoicexpress::Models::Message)

        params = { :body => message, :klass => Invoicexpress::Models::DebitNote }
        put("debit_notes/#{debit_note_id}/email-document.xml", params.merge(options))
      end

    end
  end
end
