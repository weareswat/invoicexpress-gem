require 'invoicexpress/models/client'
require 'invoicexpress/models/invoice'

module Invoicexpress
  module Models

    class InvoiceTemplate < BaseModel
      include BaseInvoice
      tag 'invoice_template'
      element :due_days, Integer
    end


    class Schedule < BaseModel
      include HappyMapper
      tag 'schedule'
      element :id, String
      #this gets returned on get
      element :next_date, Date, :on_save => DATE_FORMAT 
      element :next_due_date, Date, :on_save => DATE_FORMAT 
      #this gets returned on list
      element :date, Date, :on_save => DATE_FORMAT 
      element :due_date, Date, :on_save => DATE_FORMAT 
      element :reference, String
      element :observations, String
      element :retention, Float
      has_one :client, Client
      element :currency, String
      has_many :items, Item, :on_save => Proc.new { |value|
        Items.new(:items => value)
      }
      element :sum, Float
      element :discount, Float
      element :before_taxes, Float
      element :taxes, Float
      element :total, Float
      has_many :sent_invoices, Invoice
      has_one :invoice_template, InvoiceTemplate
      #these fields are only used on create...
      element :start_date, Date,  :on_save => DATE_FORMAT 
      element :end_date, Date, :on_save => DATE_FORMAT 
      element :create_back, String
      element :schedule_type, String
      element :interval, String
      element :send_to_client, String
      element :description, String
    end

    class Schedules < BaseModel
      include HappyMapper
      tag 'schedules'
      has_many :schedules, Schedule
    end
  end
end
