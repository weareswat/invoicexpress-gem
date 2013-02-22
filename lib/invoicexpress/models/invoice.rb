require 'invoicexpress/models/client'

module Invoicexpress
  module Models
    class Tax < BaseModel
      include HappyMapper

      tag 'tax'
      element :name, String
      element :value, Float
    end

    class Item < BaseModel
      include HappyMapper

      tag 'item'
      element :id, Integer
      element :name, String
      element :description, String
      element :unit_price, Float
      element :quantity, Float
      element :unit, String
      element :tax, Tax
      element :discount, Float
    end

    class Items < BaseModel
      include HappyMapper

      tag 'items'
      attribute :type, String, :on_save => Proc.new { |value|
        "array"
      }
      has_many :items, Item
    end

    module BaseInvoice
      def self.included(base)
        base.class_eval do
          include HappyMapper

          element :id, Integer
          element :status, String
          element :sequence_number, String
          element :date, Date
          element :due_date, Date
          element :reference, String
          element :observations, String
          element :retention, Float
          element :tax_exemption, String

          has_one :client, Client
          has_many :items, Item, :on_save => Proc.new { |value|
            Items.new(:items => value)
          }

          element :currency, String
          element :sum, Float
          element :discount, Float
          element :before_taxes, Float
          element :taxes, Float
          element :total, Float
          element :mb_reference, Integer
        end

      end
    end

    class Invoice < BaseModel
      include BaseInvoice
      tag 'invoice'
    end

    class CashInvoice < BaseModel
      include BaseInvoice
      tag 'cash_invoice'
    end

    class CreditNote < BaseModel
      include BaseInvoice
      tag 'credit_note'
    end

    class DebitNote < BaseModel
      include BaseInvoice
      tag 'debit_note'
    end

    class InvoiceResult
      include HappyMapper

      tag 'results'
      element :current_page, Integer
      element :entries, Integer
      element :total_entries, Integer
    end

    class Invoices < BaseModel
      include HappyMapper

      tag 'invoices'
      has_one :results, InvoiceResult
      has_many :invoices, Invoice
    end

    class InvoiceState < BaseModel
      include HappyMapper

      tag 'invoice'
      element :state, String
      element :message, String
    end

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
    end

  end
end

