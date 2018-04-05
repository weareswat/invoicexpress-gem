require 'invoicexpress/models'

module Invoicexpress
  class Client
    module TransportGuides

      # Returns all your transport guides
      # Full docs at https://invoicexpress.com/api/transport-guides/list
      #
      # @option options [Integer] page (1) You can ask a specific page of transport guides
      # @option status[] [String] Possible values: draft, sent, canceled, second_copy.
      # @option type[] [String] Possible values: Shipping, Transport, Devolution.
      # @option non_archived [String] Possible values: true, false.
      #
      # @return [Invoicexpress::Models::TransportGuides] A struct with results (pagination) and all the transport guides
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      def transport_guides(options={})
         params = { :page => 1, 'type[]' => ['Transport'], 'status[]' => ["draft", "sent", "canceled", "second_copy"], "non_archived"=> "true", :klass=>Invoicexpress::Models::TransportGuides }

        get("transports.xml", params.merge(options))
      end

      # Returns all the information about a transport guide:
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
      # @param transport_guide_id [String] Requested transport guide id
      # @return [Invoicexpress::Models::TransportGuide] The requested transport guide
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::NotFound When the transport_guide doesn't exist
      def transport_guide(transport_guide_id, options={})
        params = { :klass => Invoicexpress::Models::TransportGuide }

        get("transports/#{transport_guide_id}.xml", params.merge(options))
      end

      # Creates a new transport guide. Also allows to create a new client and/or new items in the same request. Docs: https://invoicexpress.com/api/transport-guides/create
      # If the client name does not exist a new one is created.
      # If items do not exist with the given names, new ones will be created.
      # If item name  already exists, the item is updated with the new values.
      # Regarding item taxes, if the tax name is not found, no tax is applyed to that item.
      # Portuguese accounts should also send the IVA exemption reason if the invoice contains exempt items(IVA 0%)
      #
      # @param transport_guide [Invoicexpress::Models::TransportGuide] The transport guide to create
      # @return [Invoicexpress::Models::TransportGuide] The created transport guide
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      def create_transport_guide(transport_guide, options={})
        raise(ArgumentError, "transport guide has the wrong type") unless transport_guide.is_a?(Invoicexpress::Models::TransportGuide)

        params = { :klass => Invoicexpress::Models::TransportGuide, :body  => transport_guide }
        post("transports.xml", params.merge(options))
      end

      # Updates a transport guide
      # It also allows you to create a new client and/or items in the same request.
      # If the client name does not exist a new client is created.
      # Regarding item taxes, if the tax name is not found, no tax will be applied to that item.
      # If item does not exist with the given name, a new one will be created.
      # If item exists it will be updated with the new values
      # Be careful when updating the document items, any missing items from the original document will be deleted.
      #
      # @param transport_guide [Invoicexpress::Models::TransportGuide] The transport guide to update
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      # @raise Invoicexpress::NotFound When the transport guide doesn't exist
      def update_transport_guide(transport_guide, options={})
        raise(ArgumentError, "transport guide has the wrong type") unless transport_guide.is_a?(Invoicexpress::Models::TransportGuide)
        if !transport_guide.id
          raise ArgumentError, "CreditNote ID is required"
        end
        params = { :klass => Invoicexpress::Models::TransportGuide, :body => transport_guide.to_core }
        put("transports/#{transport_guide.id}.xml", params.merge(options))
      end

      # Changes the state of a transport guide.
      # Possible state transitions:
      # - draft to final – finalized
      # - draft to deleted – deleted
      # - settled to final – unsettled
      # - final to second copy – second_copy
      # - final or second copy to canceled – canceled
      # - final or second copy to settled – settled
      # Any other transitions will fail.
      # When canceling a transport guide you must specify a reason.
      #
      # @param transport_guide_id [String] The transport guide id to change
      # @param transport_guide_state [Invoicexpress::Models::InvoiceState] The new state
      # @return [Invoicexpress::Models::TransportGuide] The updated transport guide
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      # @raise Invoicexpress::NotFound When the transport guide doesn't exist
      def update_transport_guide_state(transport_guide_id, transport_guide_state, options={})
        raise(ArgumentError, "transport guide state has the wrong type") unless transport_guide_state.is_a?(Invoicexpress::Models::InvoiceState)

        params = { :klass => Invoicexpress::Models::TransportGuide, :body => transport_guide_state }
        put("transports/#{transport_guide_id}/change-state.xml", params.merge(options))
      end

      # Sends the transport guide through email
      #
      # @param transport_guide_id [String] The transport guide id to send
      # @param message [Invoicexpress::Models::Message] The message to send
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      # @raise Invoicexpress::NotFound When the transport guide doesn't exist
      def email_transport_guide(transport_guide_id, message, options={})
        raise(ArgumentError, "message has the wrong type") unless message.is_a?(Invoicexpress::Models::Message)

        params = { :body => message, :klass => Invoicexpress::Models::TransportGuide }
        put("transports/#{transport_guide_id}/email-document.xml", params.merge(options))
      end

    end
  end
end
