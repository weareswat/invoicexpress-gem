require 'invoicexpress/models/client'
require 'invoicexpress/models/tax'
require 'invoicexpress/models/item'
require 'invoicexpress/models/address'

module Invoicexpress
  module Models

    # Fields common to all transport models, necessary for create/update
    module BaseTransportGuide
      def self.included(base)
        base.class_eval do
          include HappyMapper
          element :id, Integer
          element :date, Date, :on_save => DATE_FORMAT
          element :due_date, Date, :on_save => DATE_FORMAT
          element :loaded_at, DateTime, :on_save => DATETIME_FORMAT
          element :license_plate, String #http://www.gcse.com/english/licence.htm
          has_one :address_from, AddressFrom, tag: "address_from"
          has_one :address_to, AddressTo, tag: "address_to"

          element :reference, String
          element :observations, String
          element :retention, Float
          element :tax_exemption, String
          element :sequence_id, Integer
          element :manual_sequence_number, String

          has_one :client, Client
          has_many :items, Item, :on_save => Proc.new { |value|
            Items.new(:items => value)
          }

          element :rate, String
          element :currency_code, String
        end
      end
    end


    # Fields only available with GET request
    module ExtraTransportGuide
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
          element :permalink, String
          has_one :multicurrency, Multicurrency
        end
      end

      # when we need to convert a "full" object to core
      def to_core()
        fields={
          :date => self.date,
          :due_date => self.due_date,
          :loaded_at => self.loaded_at,
          :license_plate => self.license_plate,
          :address_from => self.address_from,
          :address_to => self.address_to,
          :reference=> self.reference,
          :observations=> self.observations,
          :retention=> self.retention,
          :tax_exemption => self.tax_exemption,
          :sequence_id=> self.sequence_id,
          :manual_sequence_number=> self.manual_sequence_number,
          :client => self.client,
          :items => self.items,
          :rate=> self.rate,
          :currency_code=> self.currency_code
        }
        document = Invoicexpress::Models::CoreTransportGuide.new(fields)
      end

    end

    # Note: we need all of these models because the API crashes when we send an object with the fields from the get request.
    # example: do a get and then a update.
    class CoreTransportGuide < BaseModel
      include BaseTransportGuide
      tag 'transport'
    end

    class TransportGuide < BaseModel
      include BaseTransportGuide
      include ExtraTransportGuide
      tag 'transport'
    end

     class TransportGuides < BaseModel
      include HappyMapper

      tag 'transports'
      has_many :transports, TransportGuide
      element :current_page, Integer
      element :total_pages, Integer
      element :total_entries, Integer
      element :per_page, Integer
    end


  end
end
