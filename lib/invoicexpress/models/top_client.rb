require 'invoicexpress/models/client'

module Invoicexpress
  module Models
   
    class TopClient < BaseModel
      include HappyMapper

      tag 'top-clients'
      element :currency, String
 
      has_many :clients, Client
    end
  end
end