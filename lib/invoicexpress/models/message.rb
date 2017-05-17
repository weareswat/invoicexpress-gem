module Invoicexpress
  module Models

    class MessageClient < BaseModel
      include HappyMapper

      tag 'client'
      element :email, String
      element :save, Integer
    end

    class Message < BaseModel
      include HappyMapper

      tag 'message'
      has_one :client, MessageClient
      element :cc, String
      element :bcc, String
      element :subject, String
      element :body, String
      element :logo, Integer
    end

  end
end
