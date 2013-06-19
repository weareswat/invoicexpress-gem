require 'invoicexpress/models/invoice'
require 'invoicexpress/models/supplier'
require 'invoicexpress/models/client'

module Invoicexpress
  module Models

    module BasePurchaseOrder
      def self.included(base)
        base.class_eval do
          include HappyMapper

          tag 'purchase_order'
          element :id, Integer
          element :date, Date, :on_save => DATE_FORMAT 
          element :due_date, Date, :on_save => DATE_FORMAT 
          element :loaded_at, Date, :on_save => DATE_FORMAT 
          element :observations, String
          element :delivery_site, String
          has_one :supplier, Supplier
          has_one :client, Client
          has_many :items, Item, :on_save => Proc.new { |value|
            Items.new(:items => value)
          }
        end
      end
    end

    class CorePurchaseOrder < BaseModel
      include BasePurchaseOrder
      #tag 'purchase_order'
    end

    class PurchaseOrder < CorePurchaseOrder
      include BasePurchaseOrder
      #include HappyMapper
      #tag 'purchase_order'
      
      element :status, String
      element :sequence_number, String
      element :permalink, String 
      element :currency, String

      
      element :sum, Float
      element :discount, Float
      element :before_taxes, Float
      element :taxes, Float
      element :total, Float

      def to_core_purchase_order()
        Invoicexpress::Models::CorePurchaseOrder.new(
          :id=>self.id,
          :date=>self.date,
          :due_date=>self.due_date,
          :loaded_at=>self.loaded_at,
          :observations=>self.observations,
          :delivery_site=>self.delivery_site,
          :supplier=>self.supplier,
          :client=>self.client,
          :items=>self.items
        )
      end
    end

    class PurchaseOrders < BaseModel
      include HappyMapper
      tag 'purchase_orders'
      has_many :purchase_orders, PurchaseOrder
    end
  end
end