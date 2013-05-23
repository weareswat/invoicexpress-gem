require 'happymapper'

module Invoicexpress
  module Models
    DATE_FORMAT = Proc.new { |value| value.strftime("%d/%m/%Y") unless value.nil? }
    
    class BaseModel
      def initialize(attributes = {})
        super()

        attributes.each { |k,v| self.send("#{k}=", v) }
      end
    end
  end
end

require 'invoicexpress/models/client'
require 'invoicexpress/models/invoice'
require 'invoicexpress/models/filter'
require 'invoicexpress/models/sequence'
require 'invoicexpress/models/user'
require 'invoicexpress/models/chart'
require 'invoicexpress/models/top_client'
require 'invoicexpress/models/top_debtor'
require 'invoicexpress/models/quarterly_result'
require 'invoicexpress/models/schedule'
require 'invoicexpress/models/purchase_order'


