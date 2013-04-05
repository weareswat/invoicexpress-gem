module Invoicexpress
  class Client
    module Charts

      # Returns the invoicing chart data.
      #
      # @return [Array<Invoicexpress::Models::Chart>] An array with all the charting results
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      def invoicing_chart(options = {})
        params = { :klass => Invoicexpress::Models::Chart }
        get("api/charts/invoicing.xml", params.merge(options))
      end

      # Returns the treasury chart data.
      #
      # @return [Array<Invoicexpress::Models::Chart>] An array with all the charting results
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      def treasury_chart(options = {})
        params = { :klass => Invoicexpress::Models::Chart }
        get("api/charts/treasury.xml", params.merge(options))
      end

      # Returns your 5 top clients for which you have invoiced more. 
      #
      # @return [Array<Invoicexpress::Models::TopClient>] An array with all the charting results
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      def top_clients(options = {})
        params = { :klass => Invoicexpress::Models::TopClient }
        get("api/charts/top-clients.xml", params.merge(options))
      end

      # Returns your 5 top debtors. Values are calculated based on the due amount.
      #
      # @return [Array<Invoicexpress::Models::TopClient>] An array with all the charting results
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      def top_debtors(options = {})
        params = { :klass => Invoicexpress::Models::TopDebtor }
        get("api/charts/top-debtors.xml", params.merge(options))
      end

      # This method allows you to obtain the quarterly results.
      # Each quarter has:
      # The amount invoiced before taxes
      # Taxes amount
      # Year to date (YTD) which consists on the difference between the invoiced on the current quarter less the invoiced on the same quarter one year ago
      #
      # @param year [Integer] By default year is the current year. It should obey the format YYYY (ex.: 2010)
      # @return [Array<Invoicexpress::Models::TopClient>] An array with all the charting results
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      def quarterly_results(options = {})
        #params = { :klass => Invoicexpress::Models::QuaterlyResult }
        params = {  :klass => Invoicexpress::Models::QuaterlyResult, :year => Date.today.year }
        get("api/charts/quarterly-results.xml", params.merge(options))
      end
    end
  end
end
