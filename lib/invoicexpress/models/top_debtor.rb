require 'invoicexpress/models/client'

module Invoicexpress
  module Models
   
    class TopDebtor < BaseModel
      include HappyMapper

      tag 'top-debtors'
      element :currency, String
      has_many :clients, Client
    end
  end
end