require 'faraday'

# @api private
module Faraday
  class Response::RaiseInvoicexpressErrors < Response::Middleware
    ERROR_MAP = {
      401 => Invoicexpress::Unauthorized,
      422 => Invoicexpress::UnprocessableEntity,
      500 => Invoicexpress::InternalServerError,
    }

    def on_complete(env)
      key = env[:status].to_i

      if ERROR_MAP.has_key? key
        raise ERROR_MAP[key].new(env)
      end
    end
  end
end
