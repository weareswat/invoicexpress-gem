require 'invoicexpress/models/client'
require 'invoicexpress/models/invoice'

module Invoicexpress
  module Models

    class InvoiceTemplate < BaseModel
      include BaseInvoice
      tag 'invoice_template'
      element :due_days, Integer
    end

    module BaseSchedule
      def self.included(base)
        base.class_eval do
          include HappyMapper

          element :id, Integer
          #these fields are only used on create and update...
          element :start_date, Date,  :on_save => DATE_FORMAT 
          element :end_date, Date, :on_save => DATE_FORMAT 
          element :create_back, String
          element :schedule_type, String
          element :interval, String
          element :send_to_client, String
          element :description, String
      
          # has_many :sent_invoices, Invoice
          has_one :invoice_template, InvoiceTemplate

        end
      end
    end
 
    class CoreSchedule < BaseModel
      include BaseSchedule
      tag 'schedule'
    end

    class Schedule < CoreSchedule
      include BaseSchedule

      tag 'schedule'
      element :reference, String
      element :retention, Float
      element :currency, String
      #observation instead of description?
      element :observations, String
      #items and client instead of invoice template?
      has_many :items, Item
      has_one :client, Client
      element :sum, Float
      element :discount, Float
      element :before_taxes, Float
      element :taxes, Float
      element :total, Float
      
      #creates a object that can be used in create/update by the invoicexpress API
      def to_core_schedule()
        Invoicexpress::Models::CoreSchedule.new(
          :id=>self.id,
          :start_date=>self.start_date,
          :end_date=>self.end_date,
          :create_back=>self.create_back,
          :schedule_type=>self.schedule_type,
          :interval=>self.interval,
          :send_to_client=>self.send_to_client,
          :description=>self.description,
          :invoice_template=>self.invoice_template
        )
      end
    end

    class Schedules < BaseModel
      include HappyMapper
      tag 'schedules'
      has_many :schedules, Schedule
    end
  end
end

