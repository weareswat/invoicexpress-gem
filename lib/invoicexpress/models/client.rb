module Invoicexpress
  module Models

    class Client < BaseModel
      include HappyMapper

      element :id, Integer
      element :name, String
      element :code, Integer
      element :email, String
      element :address, String
      element :postal_code, String
      element :fiscal_id, String
      element :website, String
      element :phone, String
      element :fax, String
      element :observations, String
      element :send_options, Integer
      element :balance, Float
      element :country, String
    end

  end
end
