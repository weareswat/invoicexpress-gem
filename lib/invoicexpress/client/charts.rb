module Invoicexpress
  class Client
    module Charts

      # Returns the invoicing chart data.
      #
      # @return [Array<Invoicexpress::Models::Chart>] An array with all the charting results
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      def invoicing_chart(options = {})
        params = { :klass => Invoicexpress::Models::Chart }
        get("invoicing.xml", params.merge(options))
      end


    end
  end
end
