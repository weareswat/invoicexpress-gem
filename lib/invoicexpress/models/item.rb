
module Invoicexpress
  module Models
    class Item < BaseModel
      include HappyMapper

      tag 'item'
      element :id, Integer
      element :name, String
      element :description, String
      element :unit_price, Float
      element :quantity, Float
      element :unit, String
      has_one :tax, Tax
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
  end
end
