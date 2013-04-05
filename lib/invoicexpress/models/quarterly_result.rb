module Invoicexpress
  module Models
    
    #TODO Improve this in the future, maybe inherit
    class Quarter01 < BaseModel
      include HappyMapper
      tag 'quarter-01'
      element :invoicing, Float
      element :taxes, Float
      element :ytd, Float
    end
    class Quarter02 < BaseModel
      include HappyMapper
      tag 'quarter-02'
      element :invoicing, Float
      element :taxes, Float
      element :ytd, Float
    end
    class Quarter03 < BaseModel
      include HappyMapper
      tag 'quarter-03'
      element :invoicing, Float
      element :taxes, Float
      element :ytd, Float
    end
    class Quarter04 < BaseModel
      include HappyMapper
      tag 'quarter-04'
      element :invoicing, Float
      element :taxes, Float
      element :ytd, Float
    end
      
    class QuaterlyResult < BaseModel
      include HappyMapper
      tag 'quarterly-results'
      element :year, String
      element :currency, String
      has_one :quarter01, Quarter01
      has_one :quarter02, Quarter02
      has_one :quarter03, Quarter03
      has_one :quarter04, Quarter04
    end
  end
end