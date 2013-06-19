require 'invoicexpress/models'
module Invoicexpress
  class Client
    module PurchaseOrders

      # Returns all your purchase orders.
      # @option options [Integer] page (1) You can ask a specific page of PurchaseOrders
      #
      # @return [Array<Invoicexpress::Models::PurchaseOrder>] An array with all the PurchaseOrders
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      def purchase_orders(options = {})
        params = { :page => 1, :klass => Invoicexpress::Models::PurchaseOrder }

        get("purchase_orders.xml", params.merge(options))
      end
      
      #Creates a new purchase order.
      #Creates a new purchase order. Also allows to create a new supplier and/or new items in the same request.
      #If the supplier name does not exist a new one is created.
      #If items do not exist with the given names, new ones will be created.
      #If item name already exists, the item is updated with the new values.
      #Regarding item taxes, if the tax name is not found, no tax is applyed to that item.
      # 
      # @param purchase_order [Invoicexpress::Models::PurchaseOrder] The PurchaseOrder to create
      # @return Invoicexpress::Models::PurchaseOrder The PurchaseOrder
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      def create_purchase_order(purchase_order, options={})
        raise(ArgumentError, "purchase order has the wrong type") unless purchase_order.is_a?(Invoicexpress::Models::PurchaseOrder)

        params = { :klass => Invoicexpress::Models::PurchaseOrder, :body => purchase_order }
        post("purchase_orders.xml", params.merge(options))
      end
      
      # Returns a specific purchase order. 
      #
      # @param purchase_order [Invoicexpress::Models::PurchaseOrder, String] The purchase order or purchase orderID
      # @return Invoicexpress::Models::PurchaseOrder The PurchaseOrder
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::NotFound When the purchase_order doesn't exist
      def purchase_order(purchase_order, options={})
        params = { :klass => Invoicexpress::Models::PurchaseOrder }

        get("purchase_orders/#{id_from_purchase_order(purchase_order)}.xml", params.merge(options))
      end
 
      # Updates a purchase order
      #Updates a purchase order. Also allows to create a new supplier and/or new items in the same request.
      #If the supplier name does not exist a new one is created.
      #If items do not exist with the given names, new ones will be created.
      #If item name already exists, the item is updated with the new values.
      #Regarding item taxes, if the tax name is not found, no tax is applyed to that item.
      #Be careful when updating the invoice items, any missing items from the original invoice will be deleted.
      #
      # @param purchase_order [Invoicexpress::Models::PurchaseOrder] The Purchase Order to update
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      # @raise Invoicexpress::NotFound When the credit note doesn't exist
      def update_purchase_order(purchase_order, options={})
        raise(ArgumentError, "purchase order has the wrong type") unless purchase_order.is_a?(Invoicexpress::Models::PurchaseOrder)

        params = { :klass => Invoicexpress::Models::PurchaseOrder, :body => purchase_order.to_core_purchase_order }
        put("purchase_orders/#{purchase_order.id}.xml", params.merge(options))
      end

      # Changes the state of a purchase order.
      #Possible state transitions:
      #- draft to final – finalized
      #- draft to deleted – deleted
      #- final to second_copy – second_copy
      #- final to accepted – accepted
      #- final to refused – refused
      #- final to canceled – canceled
      #- second_copy to canceled – canceled
      #- accepted to refused – refused
      #- accepted to completed – completed
      #- refused to canceled – canceled
      #- refused to accepted – accepted
      #Any other transitions will fail.
      #When canceling an purchase order you must specify a reason.
      #
      # @param purchase_order_id [String] The purchase order id to change
      # @param purchase_order_state [Invoicexpress::Models::InvoiceState] The new state
      # @return [Invoicexpress::Models::PurchaseOrder] The updated Purchase Order
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      # @raise Invoicexpress::NotFound When the credit note doesn't exist
      def update_purchase_order_state(purchase_order_id, purchase_order_state, options={})
        raise(ArgumentError, "purchase_order_state has the wrong type") unless purchase_order_state.is_a?(Invoicexpress::Models::InvoiceState)

        params = { :klass => Invoicexpress::Models::PurchaseOrder, :body => purchase_order_state }
        put("purchase_orders/#{purchase_order_id}/change-state.xml", params.merge(options))
      end

      # Sends the purchase order by email
      #
      # @param purchase_order_id [String] The credit note id to send
      # @param message [Invoicexpress::Models::Message] The message to send
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      # @raise Invoicexpress::NotFound When the credit note doesn't exist
      def purchase_order_mail(purchase_order_id, message, options={})
        raise(ArgumentError, "message has the wrong type") unless message.is_a?(Invoicexpress::Models::Message)

        params = { :body => message, :klass => Invoicexpress::Models::PurchaseOrder }
        put("purchase_orders/#{purchase_order_id}/email-document.xml", params.merge(options))
      end

      private
      def id_from_purchase_order(item)
        if item.is_a?(Invoicexpress::Models::PurchaseOrder)
          item.id
        elsif item.is_a?(String)
          item
        elsif item.is_a?(Integer)
          item.to_s
        else
          raise ArgumentError, "Cannot get Purchase Order id from #{item}"
        end
      end
    end
  end
end
