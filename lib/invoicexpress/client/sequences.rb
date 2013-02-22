module Invoicexpress
  class Client
    module Sequences

      # Returns all your sequences.
      #
      # @return [Array<Invoicexpress::Models::Sequence>] An array with all the sequences
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      def sequences(options = {})
        params = { :klass => Invoicexpress::Models::Sequence }

        get("sequences.xml", params.merge(options))
      end

      # Returns a specific sequence. 
      #
      # @param sequence [Invoicexpress::Models::Sequence, String] The sequence or sequence ID
      # @return Invoicexpress::Models::Sequence The sequence
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::NotFound When the sequence doesn't exist
      def sequence(sequence, options={})
        params = { :klass => Invoicexpress::Models::Sequence }

        get("sequences/#{id_from_sequence(sequence)}.xml", params.merge(options))
      end

      # Creates a new sequence.
      #
      # @param sequence [Invoicexpress::Models::Sequence] The sequence to create
      # @return Invoicexpress::Models::Sequence The sequence
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      def create_sequence(sequence, options={})
        raise(ArgumentError, "sequence has the wrong type") unless sequence.is_a?(Invoicexpress::Models::Sequence)

        params = { :klass => Invoicexpress::Models::Sequence, :body => sequence }
        post("sequences.xml", params.merge(options))
      end

      # Updates a specific sequence.
      # Only sequences with no finalized invoices can be updated.
      #
      # @param sequence [Invoicexpress::Models::Sequence] The sequence to update
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::NotFound When the sequence doesn't exist
      # @raise Invoicexpress::UnprocessableEntity When there are errors on the submission
      def update_sequence(sequence, options={})
        raise(ArgumentError, "sequence has the wrong type") unless sequence.is_a?(Invoicexpress::Models::Sequence)

        params = { :klass => Invoicexpress::Models::Sequence, :body => sequence }
        put("sequences/#{sequence.id}.xml", params.merge(options))
      end

      private
      def id_from_sequence(item)
        if item.is_a?(Invoicexpress::Models::Sequence)
          item.id
        elsif item.is_a?(String)
          item
        elsif item.is_a?(Integer)
          item.to_s
        else
          raise ArgumentError, "Cannot get sequence id from #{item}"
        end
      end

    end
  end
end
