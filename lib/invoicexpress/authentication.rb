module Invoicexpress
  module Authentication
    def authentication
      if api_key
        { :api_key => api_key }
      else
        {}
      end
    end

    def authenticated?
      !authentication.empty?
    end
  end
end
