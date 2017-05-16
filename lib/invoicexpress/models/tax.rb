module Invoicexpress
  module Models
    class Tax < BaseModel
      include HappyMapper

      tag 'tax'
      element :id, Integer
      element :name, String
      element :value, Float
      element :region, String
      element :default_tax, Integer
    end
  end
end
