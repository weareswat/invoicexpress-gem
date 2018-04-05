# This objects are used in tranport guides
module Invoicexpress
  module Models

    module BaseAddress
      def self.included(base)
        base.class_eval do
          include HappyMapper
          element :detail, String
          element :city, String
          element :postal_code, String
          element :country, String
        end
      end
    end

    class Address < BaseModel
      include BaseAddress
      tag 'address'
    end

    class AddressFrom < BaseModel
      include BaseAddress
      tag 'address_from'
    end

    class AddressTo < BaseModel
      include BaseAddress
      tag 'address_to'
    end

  end
end
