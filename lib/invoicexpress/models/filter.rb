module Invoicexpress
  module Models
    class FilterStatus < BaseModel
      include HappyMapper

      tag 'status'
      has_many :options, String, :tag => 'option'
    end

    class FilterByType < BaseModel
      include HappyMapper

      tag 'by_type'
      has_many :options, String, :tag => 'option'
    end

    class FilterArchived < BaseModel
      include HappyMapper

      tag 'archived'
      has_many :options, String, :tag => 'option'
    end

    class Filter < BaseModel
      include HappyMapper

      tag 'filter'
      element :status, FilterStatus
      element :by_type, FilterByType
      element :archived, FilterArchived

      def initialize(args = {})
        if args[:status] && args[:status].is_a?(Array)
          o = FilterStatus.new
          o.options = []
          o.options = args[:status].map(&:to_s)

          self.status = o
        end

        if args[:by_type] && args[:by_type].is_a?(Array)
          o = FilterByType.new
          o.options = []
          o.options = args[:by_type].map(&:to_s)

          self.by_type = o
        end

        if args[:archived] && args[:archived].is_a?(Array)
          o = FilterArchived.new
          o.options = []
          o.options = args[:archived].map(&:to_s)

          self.archived = o
        end

      end
    end
  end
end
