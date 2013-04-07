module Invoicexpress
  class Client
    module Taxes

      # Returns all your taxes (lol)
      #
      # @return [Array<Invoicexpress::Models::Tax>] An array with all your taxes
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      def taxes(options = {})
        params = { :klass => Invoicexpress::Models::Tax }

        get("taxes.xml", params.merge(options))
      end

      # Returns a specific tax. 
      #
      # @param tax [Invoicexpress::Models::Tax, String] The tax or tax ID
      # @return Invoicexpress::Models::Tax The tax
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::NotFound When the tax doesn't exist
      def tax(tax, options={})
        params = { :klass => Invoicexpress::Models::Tax }

        get("taxes/#{id_from_tax(tax)}.xml", params.merge(options))
      end

      # Creates a tax.
      #
      # @param tax [Invoicexpress::Models::Tax] The tax to create
      # @return Invoicexpress::Models::Tax The tax created
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      def create_tax(tax, options={})
        raise(ArgumentError, "tax has the wrong type") unless tax.is_a?(Invoicexpress::Models::Tax)

        params = { :klass => Invoicexpress::Models::Tax, :body => tax }
        post("taxes.xml", params.merge(options))
      end

      # Updates a tax.
      #
      # @param tax [Invoicexpress::Models::Tax] The tax to update
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::NotFound When the tax doesn't exist
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      def update_tax(tax, options={})
        raise(ArgumentError, "tax has the wrong type") unless tax.is_a?(Invoicexpress::Models::Tax)

        params = { :klass => Invoicexpress::Models::Tax, :body => tax }
        put("taxes/#{tax.id}.xml", params.merge(options))
      end

      # Deletes a tax.
      #
      # @param tax [Invoicexpress::Models::Tax, String] The tax or tax ID
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::NotFound When the tax doesn't exist
      def delete_tax(tax, options={})
        params = { :klass => Invoicexpress::Models::Tax }

        delete("taxes/#{id_from_tax(tax)}.xml", params.merge(options))
      end

      private
      def id_from_tax(item)
        if item.is_a?(Invoicexpress::Models::Tax)
          item.id
        elsif item.is_a?(String)
          item
        elsif item.is_a?(Integer)
          item.to_s
        else
          raise ArgumentError, "Cannot get tax id from #{item}"
        end
      end

    end
  end
end
