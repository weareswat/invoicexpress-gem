require 'invoicexpress/models/client'
require 'invoicexpress/models/tax'
require 'invoicexpress/models/item'
require 'invoicexpress/models/multicurrency'

module Invoicexpress
  module Models


    # Fields common to all invoice models, necessary for create/update
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
          element :manual_sequence_number, String

          element :mb_reference, String
          # currency codes
          element :rate, String
          element :currency_code, String
          has_one :client, Client
          has_many :items, Item, :on_save => Proc.new { |value|
            Items.new(:items => value)
          }
        end
      end
    end

    # Extra fields for creating credit notes and debit notes
    module BaseCreditNote
      def self.included(base)
        base.class_eval do
          #The (owner) invoice associated to this credit-note.
          element :owner_invoice_id, String
        end
      end
    end

    # Fields only available with GET request
    module ExtraInvoice
      def self.included(base)
        base.class_eval do
          element :status, String
          element :archived, String
          element :sequence_number, String
          element :inverted_sequence_number, String
          element :currency, String
          element :sum, Float
          element :discount, Float
          element :before_taxes, Float
          element :taxes, Float
          element :total, Float
          element :mb_reference, Integer
          element :permalink, String
          element :saft_hash, String
          has_one :multicurrency, Multicurrency
        end
      end

      def to_core()
        fields={
          :date => self.date,
          :due_date => self.due_date,
          :reference=> self.reference,
          :observations=> self.observations,
          :retention=> self.retention,
          :tax_exemption => self.tax_exemption,
          :sequence_id=> self.sequence_id,
          :manual_sequence_number=> self.manual_sequence_number,
          :client => self.client,
          :items => self.items,
          :currency_code=> self.currency_code,
          :rate=> self.rate,
          :mb_reference=> self.mb_reference
        }
        case self.class.to_s
        when "Invoicexpress::Models::SimplifiedInvoice"
          invoice = Invoicexpress::Models::CoreSimplifiedInvoice.new(fields)
        when "Invoicexpress::Models::CashInvoice"
          invoice = Invoicexpress::Models::CoreCashInvoice.new(fields)
        when "Invoicexpress::Models::CreditNote"
          fields.merge! owner_invoice_id: self.owner_invoice_id 
          invoice = Invoicexpress::Models::CoreCreditNote.new(fields)
        when "Invoicexpress::Models::DebitNote"
          fields.merge! owner_invoice_id: self.owner_invoice_id
          invoice = Invoicexpress::Models::CoreDebitNote.new(fields)
        else
          invoice = Invoicexpress::Models::CoreInvoice.new(fields)
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
      include BaseCreditNote
      tag 'credit_note'
    end

    class CoreDebitNote < BaseModel
      include BaseInvoice
      include BaseCreditNote
      tag 'debit_note'
    end

    #added for app.invoicexpress api version
    class CoreInvoiceReceipt < BaseModel
      include BaseInvoice
      tag 'invoice_receipt'
    end

    #added for app.invoicexpress api version
    class InvoiceReceipt < BaseModel
      include BaseInvoice
      include ExtraInvoice
      tag 'invoice_receipt'
    end

    class SimplifiedInvoice < BaseModel
      include BaseInvoice
      include ExtraInvoice
      tag 'simplified_invoice'
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
      include BaseCreditNote
      include ExtraInvoice
      tag 'credit_note'
    end

    class DebitNote < BaseModel
      include BaseInvoice
      include BaseCreditNote
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

    #added for app.invoicexpress api version
    class InvoiceReceipts < BaseModel
      include HappyMapper

      tag 'invoice_receipts'
      has_one :results, InvoiceResult
      has_many :invoice_receipts, CashInvoice
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



  end
end
