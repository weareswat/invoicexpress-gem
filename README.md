# invoiceXpress

Gem for invoicexpress API
Reference: http://en.invoicexpress.com/api/overview/introduction/

## Dependencies

Run bundle, the project should need:
Happymapper
Faraday
And pretzels!

## Progress

* Client        - 100%
* Sequences     - 100%
* Users         - 100%
* Invoices      - 100%
* Cash Invoices - 100%
* Items         - 100%
* Charts        - 100%
* Debit Notes   - 100%
* Credit Notes  - 10%
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
 
### Example

If using from inside a rails project:
    require 'invoicexpress'
 
    client = Invoicexpress::Client.new(
      :screen_name => "yourusername",
      :api_key     => "yourapikey"
    )

    invoices  = client.invoices
    invoice   = client.invoice(1042320)
    chart  = client.treasury_chart

### Documentation

We've included docs for all methods. Refer to the client section.

### Examples

The Github wiki has examples for (most) of the methods.
