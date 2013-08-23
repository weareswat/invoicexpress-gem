module Invoicexpress
  module Models
    class Value
      include HappyMapper 
      tag "value" 
      content "value"
      attribute :xid, Integer 
    end 

    class Series < BaseModel
      include HappyMapper

      tag 'series'
      has_many :values, Value 
    end
    
    class Graph < BaseModel
      include HappyMapper

      tag 'graph'
      attribute :gid, String 
      attribute :title, String
      has_many :values, Value 
    end
    
    class Graphs < BaseModel
      include HappyMapper

      tag 'graphs'
      has_many :graphs, Graph
    end

    class Chart < BaseModel
      include HappyMapper

      tag 'chart'
      has_one :series, Series
      has_many :graphs, Graph
    end
  end
end