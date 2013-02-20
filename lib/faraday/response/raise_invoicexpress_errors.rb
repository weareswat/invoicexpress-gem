require 'faraday'

# @api private
module Faraday
  class Response::RaiseInvoicexpressErrors < Response::Middleware
    ERROR_MAP = {
      422 => Invoicexpress::UnprocessableEntity
    }

    def on_complete(env)
      key = env[:status].to_i

      if ERROR_MAP.has_key? key
        raise ERROR_MAP[key].new(env)
      end
    end
  end
end
