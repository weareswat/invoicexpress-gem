# invoiceXpress GEM

[![Gem Version](https://badge.fury.io/rb/invoicexpress.svg)](http://badge.fury.io/rb/invoicexpress) [![Build Status](https://travis-ci.org/weareswat/invoicexpress-gem.svg)](https://travis-ci.org/weareswat/invoicexpress-gem) [![Code Climate](https://codeclimate.com/github/weareswat/invoicexpress-gem/badges/gpa.svg)](https://codeclimate.com/github/weareswat/invoicexpress-gem)

Gem for invoicexpress API at http://invoicexpress.com
Created with Reference: http://en.invoicexpress.com/api/overview/introduction/

## Dependencies

Run bundle, the project should need:
* Invoicexpress API Key
* Happymapper
* Faraday
* And pretzels!

## Progress

* Client        - 100%
* Sequences     - 100%
* Users         - 100%
* Invoices      - 100%
* Cash Invoices - 100%
* Items         - 100%
* Charts        - 100%
* Debit Notes   - 100%
* Credit Notes  - 100%
* Taxes         - 100%
* Schedules     - 100%
* Sim. Invoices - 100%
* Purch. Orders - 100%

## Tests

* Client        - 100%
* Sequences     - 100%
* Users         - 100%
* Charts        - 100%
* Taxes         - 100%
* Schedules     - 100%
* Invoices      - 100%
* Sim. Invoices - 100%
* Credit Notes  - 100%
* Purch. Orders - 100%
 
## Documentation

We've included docs for all methods. Refer to the doc folder and client section.

## Examples

If using from inside a rails project use:
    require 'invoicexpress'
 
    client = Invoicexpress::Client.new(
      :screen_name => "yourusername",
      :api_key     => "yourapikey"
    )

Here's some examples for the most common objects and endpoints. You could also take a look at the spec folder for extensive tests.

### Simplified Invoices

    simple_invoices = @client.simplified_invoices
    puts simple_invoices

    invoice = Invoicexpress::Models::SimplifiedInvoice.new(
      :date => Date.new(2013, 6, 16),
      :due_date => Date.new(2013, 6, 16),
      :tax_exemption => "M01",
      :observations=> 'new',
      :client => Invoicexpress::Models::Client.new(
        :name => "Pedro Sousa",
        :email=> 'psousa@thinkorange.pt'
      ),
      :items => [
        Invoicexpress::Models::Item.new(
          :name => "Item 6",
          :unit_price => 120,
          :quantity => 2,
          :unit => "unit",
        ),
        Invoicexpress::Models::Item.new(
          :name => "Item AM",
          :unit_price => 50,
          :quantity => 1,
          :unit => "unit",
        )
      ]
    )
    simple_invoice = @client.create_simplified_invoice(invoice)
    simple_invoice = @client.simplified_invoice(1425061)
    simple_invoice.tax_exemption="M02"
    @client.update_simplified_invoice(simple_invoice)
    state = Invoicexpress::Models::InvoiceState.new(
      :state => "finalized"
    )
    @client.update_simplified_invoice_state(simple_invoice.id, state)

### Credit Notes

        credit_notes = @client.credit_notes
        puts credit_notes

        cnote = Invoicexpress::Models::CreditNote.new(
          :date => Date.new(2013, 6, 11),
          :due_date => Date.new(2013, 6, 11),
          :tax_exemption => "M01",
          :client => Invoicexpress::Models::Client.new(
            :name => "Pedro Sousa",
            :email=> 'psousa@thinkorange.pt'
          ),
          :items => [
            Invoicexpress::Models::Item.new(
              :name => "Item 1",
              :unit_price => 60,
              :quantity => 2,
              :unit => "unit",
            ),
            Invoicexpress::Models::Item.new(
              :name => "Item 2",
              :unit_price => 50,
              :quantity => 1,
              :unit => "unit",
            )
          ]
        )
        cnote = @client.create_credit_note(cnote)
        cnote_load = @client.credit_note(cnote.id)
        cnote_load.tax_exemption="M02"
        @client.update_credit_note(cnote_load)
        state = Invoicexpress::Models::InvoiceState.new(
          :state => "finalized"
        )
        @client.update_credit_note_state(cnote_load.id, state)

### Debit Notes


        debit_notes = @client.debit_notes
        puts debit_notes

        dnote = Invoicexpress::Models::DebitNote.new(
          :date => Date.new(2013, 5, 1),
          :due_date => Date.new(2013, 6, 1),
          :tax_exemption => "M01",
          :client => Invoicexpress::Models::Client.new(
            :name => "Pedro Sousa",
            :email=> 'psousa@thinkorange.pt'
          ),
          :items => [
            Invoicexpress::Models::Item.new(
              :name => "Item 1",
              :unit_price => 60,
              :quantity => 2,
              :unit => "unit",
            )
          ]
        )
        dnote = @client.create_debit_note(dnote)
        dnote_loaded = @client.debit_note(1503654)
        dnote.tax_exemption="M02"
        @client.update_debit_note(dnote)
        state = Invoicexpress::Models::InvoiceState.new(
          :state => "finalized"
        )
        dnote = @client.update_credit_note_state(dnote.id, state)

### Invoices

        invoices = @client.invoices
        invoices.invoices.count
        invoices.current_page
        puts invoices

        invoice = @client.invoice(1042320)

        invoice = Invoicexpress::Models::Invoice.new(
          :date => Date.new(2013, 6, 18),
          :due_date => Date.new(2013, 6, 18),
          :tax_exemption => "M01",
          :client => Invoicexpress::Models::Client.new(
            :name => "Ruben Fonseca"
          ),
          :items => [
            Invoicexpress::Models::Item.new(
              :name => "Item 1",
              :unit_price => 30,
              :quantity => 1,
              :unit => "unit",
            )
          ]
        )
        invoice = @client.create_invoice(invoice)

        invoice.observations="updated from api"
        @client.update_invoice(invoice)

        invoice_state = Invoicexpress::Models::InvoiceState.new(
          :state => "finalized"
        )
        @client.update_invoice_state(invoice.id, invoice_state)

        message = Invoicexpress::Models::Message.new(
          :client => Invoicexpress::Models::Client.new(
            :email => "info@thinkorange.pt",
            :name=>"Chuck Norris"
          ),
          :subject => "Your invoice",
          :body => "Attached to this email"
        )
        @client.invoice_email(invoice.id, message)

### Charts

        chart_i = @client.invoicing_chart
        chart_t = @client.treasury_chart
        top_c = @client.top_clients
        top_d = @client.top_debtors
        quarter = @client.quarterly_results(2011)
      
### Schedules


        new_schedule = Invoicexpress::Models::Schedule.new(
          :start_date => Date.new(2013, 6, 16),
          :end_date => Date.new(2013, 8, 18),
          :create_back => "Yes",
          :schedule_type => "Monthly",
          :interval => 2,
          :send_to_client => "No",
          :description=> "created from API.",
          :invoice_template=> Invoicexpress::Models::InvoiceTemplate.new(
            :due_days=>1,
            :client => Invoicexpress::Models::Client.new(
              :name => "Rui Leitão",
              :email=>'rmleitao@thinkorange.pt'
            ),
            :items => [
              Invoicexpress::Models::Item.new(
                :name => "Item 1",
                :unit_price => 30,
                :quantity => 2,
                :unit => "unit",
                :tax=>Invoicexpress::Models::Tax.new(
                  :name => "IVA23",
                )
              ),
              Invoicexpress::Models::Item.new(
                :name => "Item 2",
                :unit_price => 60,
                :quantity => 5,
                :unit => "unit",
                :tax=>Invoicexpress::Models::Tax.new(
                  :name => "IVA23",
                )
              )
            ]
          )
        )
        schedule = @client.create_schedule(new_schedule)

To update a schedule we need to pass these fields.

        schedule.invoice_template=Invoicexpress::Models::InvoiceTemplate.new(
            :due_days=>1,
            :client => Invoicexpress::Models::Client.new(
              :name => "Rui Leitão",
              :email=>'rmleitao@thinkorange.pt'
            ),
            :items => [
              Invoicexpress::Models::Item.new(
                :name => "Item 1",
                :unit_price => 30,
                :quantity => 2,
                :unit => "unit",
                :tax=>Invoicexpress::Models::Tax.new(
                  :name => "IVA23",
                )
              ),
              Invoicexpress::Models::Item.new(
                :name => "Item 2",
                :unit_price => 60,
                :quantity => 5,
                :unit => "unit",
                :tax=>Invoicexpress::Models::Tax.new(
                  :name => "IVA23",
                )
              )
            ]
          )
        schedule.interval=2
        schedule.schedule_type="Monthly"
        schedule.send_to_client="No"
        schedule.description="Maybe"
        schedule.create_back="No"
        @client.update_schedule(schedule)

        @client.activate schedule
        @client.deactivate_schedule schedule

### Purchase Orders


        orders=@client.purchase_orders
        purchase_order = Invoicexpress::Models::PurchaseOrder.new(
          :date => Date.new(2013, 5, 30),
          :due_date => Date.new(2013, 8, 8),
          :loaded_at => Date.new(2013, 5, 30),
          :delivery_site=>'LX',
          :supplier => Invoicexpress::Models::Supplier.new(
            :name => "Pedro Sousa",
          ),
          :items => [
            Invoicexpress::Models::Item.new(
              :name => "Item 1",
              :unit_price => 60,
              :quantity => 2,
              :unit => "unit",
              :tax=> Invoicexpress::Models::Tax.new(
                :name=>'IVA23'
              )
            )
          ]
        )
        purchase_order = @client.create_purchase_order(purchase_order)
