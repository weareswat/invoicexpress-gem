module Invoicexpress
  module Models
    class Sequence < BaseModel
      include HappyMapper

      tag 'sequence'
      element :id, String
      element :serie, String
      element :current_invoice_sequence_id, Integer
      element :current_invoice_number, Integer
      element :current_credit_note_sequence_id, Integer
      element :current_credit_note_number, Integer
      element :current_debit_note_number, Integer
      element :default_sequence, Boolean
      element :current_simplified_invoice_sequence_id, Integer
      element :current_simplified_invoice_number, Integer
      element :current_debit_note_sequence_id, Integer
      element :current_debit_note_number, Integer
      element :current_receipt_sequence_id, Integer
      element :current_receipt_number, Integer
      element :current_shipping_sequence_id, Integer
      element :current_shipping_number, Integer
      element :current_transport_sequence_id, Integer
      element :current_transport_number, Integer
      element :current_proforma_sequence_id, Integer
      element :current_proforma_number, Integer
      element :current_quote_sequence_id, Integer
      element :current_quote_number, Integer
      element :current_fees_note_sequence_id, Integer
      element :current_fees_note_number, Integer
      element :current_purchase_order_sequence_id, Integer
      element :current_purchase_order_number, Integer
    end
  end
end
