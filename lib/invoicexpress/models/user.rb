module Invoicexpress
  module Models

    class Credentials < BaseModel
      include HappyMapper

      tag 'credentials'
      element :login, String
      element :password, String
    end

    class Account < BaseModel
      include HappyMapper

      tag 'account'
      element :id, String
      element :name, String
      element :url, String
      element :api_key, String
      element :state, String
    end

    class ChangeAccountTo < BaseModel
      include HappyMapper

      tag 'change_account_to'
      element :id, String
    end

  end
end
