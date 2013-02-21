require 'happymapper'

module Invoicexpress
  module Models
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
