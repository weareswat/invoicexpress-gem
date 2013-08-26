module Invoicexpress
  module Models

    class Supplier < BaseModel
      include HappyMapper
      tag 'supplier'
      element :id, String
      element :name, String
      element :code, String
      element :email, String
      element :address, String
      element :postal_code, String
      element :fiscal_id, String
    end
    
  end
end
