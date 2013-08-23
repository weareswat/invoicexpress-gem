require 'invoicexpress/authentication'
require 'invoicexpress/connection'
require 'invoicexpress/request'

require 'invoicexpress/models'

require 'invoicexpress/client/clients'
require 'invoicexpress/client/invoices'
require 'invoicexpress/client/cash_invoices'
require 'invoicexpress/client/items'
require 'invoicexpress/client/sequences'
require 'invoicexpress/client/users'
require 'invoicexpress/client/charts'
require 'invoicexpress/client/taxes'
require 'invoicexpress/client/schedules'
require 'invoicexpress/client/purchase_orders'
require 'invoicexpress/client/debit_notes'
require 'invoicexpress/client/credit_notes'
require 'invoicexpress/client/simplified_invoices'


module Invoicexpress
  # Please refer to each section inside the client for the respective documentation.
  #
  #
  class Client
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    def initialize(options={})
      options = Invoicexpress.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    include Invoicexpress::Authentication
    include Invoicexpress::Connection
    include Invoicexpress::Request

    include Invoicexpress::Client::Clients
    include Invoicexpress::Client::Invoices
    include Invoicexpress::Client::CashInvoices
    include Invoicexpress::Client::Items
    include Invoicexpress::Client::Sequences
    include Invoicexpress::Client::Users
    include Invoicexpress::Client::Charts
    include Invoicexpress::Client::Taxes
    include Invoicexpress::Client::Schedules

    include Invoicexpress::Client::PurchaseOrders
    include Invoicexpress::Client::DebitNotes
    include Invoicexpress::Client::CreditNotes
    include Invoicexpress::Client::SimplifiedInvoices
    
  end
end
