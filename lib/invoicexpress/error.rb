require 'happymapper'

module Invoicexpress
  module Models
    class Errors
      include HappyMapper

      has_many :error, String
      alias :errors :error
    end
  end

  # Custom error class for rescuing from all Invoicexpress errors
  #
  class Error < StandardError
    attr_accessor :messages

    def initialize(response=nil)
      @response = response
      @messages = []

      super(build_error_message)
    end

    def response_body
      @response_body ||=
        if (body = @response[:body]) && !body.empty?
          if body.is_a?(String)
            Invoicexpress::Models::Errors.parse(body)
          else
            body
          end
        else
          nil
        end
    end

    private

    def build_error_message
      return nil  if @response.nil?

      message = if response_body
        @messages = response_body.errors
        ": " + @messages.join(", ")
      else
        ''
      end

      "#{@response[:method].to_s.upcase} #{@response[:url].to_s}: #{@response[:status]}#{message}"
    end
  end

  # Raised when Invoicexpress returns a 401 HTTP status code
  class Unauthorized < Error; end

  # Raised when Invoicexpress returns a 422 HTTP status code
  class UnprocessableEntity < Error; end
end
