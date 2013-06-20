require 'invoicexpress/models/client'

module Invoicexpress
  module Models

    class Tax < BaseModel
      include HappyMapper

      tag 'tax'
      element :id, Integer
      element :name, String
      element :value, Float
      element :region, String
      element :default_tax, Integer
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
          element :date, Date, :on_save => DATE_FORMAT 
          element :due_date, Date, :on_save => DATE_FORMAT
          element :reference, String
          element :observations, String
          element :retention, Float
          element :tax_exemption, String
          element :sequence_id, Integer
          element :mb_reference, String
          has_one :client, Client
          has_many :items, Item, :on_save => Proc.new { |value|
            Items.new(:items => value)
          }
        end
      end
    end

    module ExtraInvoice
      def self.included(base)
        base.class_eval do
          element :status, String
          element :sequence_number, String
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
    
    # Note: we need all of these models because the API crashes when we send an object with the fields from the get request.
    # example: do a get and then a update.
    class CoreSimplifiedInvoice < BaseModel
      include BaseInvoice
      tag 'simplified_invoice'
    end

    class CoreInvoice < BaseModel
      include BaseInvoice
      tag 'invoice'
    end

    class CoreCashInvoice < BaseModel
      include BaseInvoice
      tag 'cash_invoice'
    end

    class CoreCreditNote < BaseModel
      include BaseInvoice
      tag 'credit_note'
    end

    class CoreDebitNote < BaseModel
      include BaseInvoice
      tag 'debit_note'
    end

    class SimplifiedInvoice < BaseModel
      include BaseInvoice
      include ExtraInvoice
      tag 'simplified_invoice'
      def to_core()
        invoice = Invoicexpress::Models::CoreSimplifiedInvoice.new(
          :date => self.date,
          :due_date => self.due_date,
          :reference=> self.reference,
          :observations=> self.observations,
          :retention=> self.retention,
          :tax_exemption => self.tax_exemption,
          :sequence_id=> self.sequence_id,
          :client => self.client,
          :items => self.items,
          :mb_reference=> self.mb_reference
        )
      end
    end
    
    class Invoice < BaseModel
      include BaseInvoice
      include ExtraInvoice
      tag 'invoice'
    end

    class CashInvoice < BaseModel
      include BaseInvoice
      include ExtraInvoice
      tag 'cash_invoice'
    end

    class CreditNote < BaseModel
      include BaseInvoice
      include ExtraInvoice
      tag 'credit_note'
    end

    class DebitNote < BaseModel
      include BaseInvoice
      include ExtraInvoice
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
      has_many :invoices, Invoice
      element :current_page, Integer
      element :total_pages, Integer
      element :total_entries, Integer
      element :per_page, Integer
    end

    class CashInvoices < BaseModel
      include HappyMapper

      tag 'cash_invoices'
      has_one :results, InvoiceResult
      has_many :cash_invoices, CashInvoice
    end

    class CreditNotes < BaseModel
      include HappyMapper

      tag 'credit_notes'
      has_one :results, InvoiceResult
      has_many :credit_notes, CreditNote
    end

    class ClientInvoices < BaseModel
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

