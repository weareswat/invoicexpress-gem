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
          if body.is_a?(String) and body.start_with?("<")
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
        if response_body.respond_to?(:errors)
          ": " + response_body.errors.join(", ")
        else
          ": " + response_body
        end
      else
        ''
      end

      "#{@response[:method].to_s.upcase} #{@response[:url].to_s}: #{@response[:status]}#{message}"
    end
  end

  # Raised when Invoicexpress returns a 401 HTTP status code
  class Unauthorized < Error; end

  # Raised when Invoicexpress returns a 404 HTTP status code
  class NotFound < Error; end

  # Raised when Invoicexpress returns a 422 HTTP status code
  class UnprocessableEntity < Error; end

  # Raised when Invoicexpress server goes dark (500 HTTP status code)
  class InternalServerError < Error; end
end
