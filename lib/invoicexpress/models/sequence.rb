module Invoicexpress
  module Models

    class Sequence < BaseModel
      include HappyMapper

      tag 'sequence'
      element :id, String
      element :serie, String
      element :current_invoice_number, Integer
      element :current_credit_note_number, Integer
      element :current_debit_note_number, Integer
      element :default_sequence, Boolean
    end

  end
end
