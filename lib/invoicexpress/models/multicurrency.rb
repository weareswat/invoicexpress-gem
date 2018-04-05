module Invoicexpress
  module Models
    class Multicurrency < BaseModel
      include HappyMapper

      tag 'multicurrency'
      element :rate, Float
      element :currency, String
      element :total, Float
    end
  end
end
