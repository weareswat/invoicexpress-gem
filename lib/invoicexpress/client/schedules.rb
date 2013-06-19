require 'invoicexpress/models'
module Invoicexpress
  class Client
    module Schedules

      # Returns all your schedules.
      #
      # @return [Array<Invoicexpress::Models::Schedule>] An array with all the schedules
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      def schedules(options = {})
        params = { :klass => Invoicexpress::Models::Schedule }

        get("schedules.xml", params.merge(options))
      end
      
      # Creates a new schedule.
      # It also allows you to create a new client and/or items in the same request.
      # If the client name does not exist a new one is created.
      # Regarding item taxes, if the tax name is not found, it is ignored and no tax is applied to that item.
      # If no item exists with the given name a new one will be created.
      # If the item exists it will be updated with the new values.
      # Be careful when updating the schedule items, as any missing items from the original invoice are deleted.
      #
      # @param schedule [Invoicexpress::Models::Schedule] The schedule to create
      # @return Invoicexpress::Models::Schedule The schedule
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      def create_schedule(schedule, options={})
        raise(ArgumentError, "schedule has the wrong type") unless schedule.is_a?(Invoicexpress::Models::Schedule)

        params = { :klass => Invoicexpress::Models::Schedule, :body => schedule }
        post("schedules.xml", params.merge(options))
      end
      
      # Returns a specific schedule. 
      #
      # @param schedule [Invoicexpress::Models::Schedule, String] The schedule or schedule ID
      # @return Invoicexpress::Models::Schedule The schedule
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::NotFound When the schedule doesn't exist
      def schedule(schedule, options={})
        params = { :klass => Invoicexpress::Models::Schedule }

        get("schedules/#{id_from_schedule(schedule)}.xml", params.merge(options))
      end

      # Updates a schedule.
      # It also allows you to create a new client and/or items in the same request.
      # If the client name does not exist a new one is created.
      # Regarding item taxes, if the tax name is not found, it is ignored and no tax is applied to that item.
      # If no item exists with the given name a new one will be created.
      # If the item exists it will be updated with the new values.
      # Be careful when updating the schedule items, as any missing items from the original invoice are deleted.
      #
      # @param schedule [Invoicexpress::Models::Schedule] The schedule to update
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      # @raise Invoicexpress::NotFound When the invoice doesn't exist
      def update_schedule(schedule, options={})
        raise(ArgumentError, "schedule has the wrong type") unless schedule.is_a?(Invoicexpress::Models::Schedule)

        params = { :klass => Invoicexpress::Models::Schedule, :body  => schedule.to_core_schedule() }
        put("schedules/#{schedule.id}.xml", params.merge(options))
      end
      
      private
      def id_from_schedule(item)
        if item.is_a?(Invoicexpress::Models::Schedule)
          item.id
        elsif item.is_a?(String)
          item
        elsif item.is_a?(Integer)
          item.to_s
        else
          raise ArgumentError, "Cannot get schedule id from #{item}"
        end
      end
    end
  end
end
