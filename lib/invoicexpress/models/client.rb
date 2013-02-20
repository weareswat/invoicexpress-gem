module Invoicexpress
  module Models
    class Client
      include HappyMapper

      element :name, String
      element :code, Integer
      element :email, String
      element :address, String
      element :postal_code, String
      element :fiscal_id, Integer
      element :website, String
      element :phone, String
      element :fax, String
      element :observations, String
      element :send_options, Integer

      def initialize(attributes = {})
        super()

        attributes.each { |k,v| self.send("#{k}=", v) }
      end
    end
  end
end
