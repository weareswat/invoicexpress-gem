require 'invoicexpress/models'

module Invoicexpress
  class Client
    module Items

      # Returns a list of all your items. 
      #
      # @return [Array<Invoicexpress::Models::Item>] An array with all your items
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      def items(options = {})
        params = { :klass => Invoicexpress::Models::Item }

        get("items.xml", params.merge(options))
      end

      # Returns a specific item.
      #
      # @param item [Invoicexpress::Models::Item, String] The item or item ID
      # @return [Invoicexpress::Models::Item] The item
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::NotFound When the item doesn't exist
      def item(item, options={})
        params = { :klass => Invoicexpress::Models::Item }

        get("items/#{id_from_item(item)}.xml", params.merge(options))
      end

      # Creates a new item.
      # Regarding item taxes, if the tax name is not found, no tax is applied to that item.
      #
      # @param item [Invoicexpress::Models::Item] The item to create
      # @return [Invoicexpress::Models::Item] The created item
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      def create_item(item, options={})
        raise(ArgumentError, "item has the wrong type") unless item.is_a?(Invoicexpress::Models::Item)

        params = { :klass => Invoicexpress::Models::Item, :body => item }
        post("items.xml", params.merge(options))
      end

      # Updates an item. 
      #
      # @param item [Invoicexpress::Models::Item] The item to update
      # @return [Invoicexpress::Models::Item] The updated item
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::NotFound When the item doesn't exist
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      def update_item(item, options={})
        raise(ArgumentError, "item has the wrong type") unless item.is_a?(Invoicexpress::Models::Item)
        
        params = { :klass => Invoicexpress::Models::Item, :body => item }
        put("items/#{item.id}.xml", params.merge(options))
      end

      # Deletes an item.
      #
      # @param item [Invoicexpress::Models::Item, String] The item or item id
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::NotFound When the item doesn't exist
      def delete_item(item, options={})
        params = { :klass => Invoicexpress::Models::Item }
        delete("items/#{id_from_item(item)}.xml", params.merge(options))
      end

      private
      def id_from_item(item)
        if item.is_a?(Invoicexpress::Models::Item)
          item.id
        elsif item.is_a?(String)
          item
        elsif item.is_a?(Integer)
          item.to_s
        else
          raise ArgumentError, "Cannot get item id from #{item}"
        end
      end

    end
  end
end
