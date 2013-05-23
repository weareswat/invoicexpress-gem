require 'invoicexpress/models/invoice'
require 'invoicexpress/models/supplier'

module Invoicexpress
  module Models

 
    class PurchaseOrder < BaseModel
      include HappyMapper
      tag 'purchase_order'
      element :id, String
      element :status, String
      element :sequence_number, String
      element :date, Date, :on_save => DATE_FORMAT 
      element :due_date, Date, :on_save => DATE_FORMAT 
      element :loaded_at, Date, :on_save => DATE_FORMAT 
      element :delivery_site, String
      element :observations, String
      element :permalink, String
      has_one :supplier, Supplier
      element :currency, String
      has_many :items, Item
      element :sum, Float
      element :discount, Float
      element :before_taxes, Float
      element :taxes, Float
      element :total, Float
    end

    class PurchaseOrders < BaseModel
      include HappyMapper
      tag 'purchase_orders'
      has_many :purchase_orders, PurchaseOrder
    end
  end
end