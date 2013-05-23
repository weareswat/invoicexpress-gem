# invoiceXpress
=============

Gem for invoicexpress API
Reference: http://en.invoicexpress.com/api/appendix/clients-country-list/

## Dependencies
=============

Run bundle, the project should need:
Happymapper
Faraday
And pretzels!

## Progress
=============

* Client        - 100%
* Sequences     - 100%
* Users         - 100%
* Invoices      - 100%
* Cash Invoices - 100%
* Items         - 100%
* Charts        - 100%
* Debit Notes   - 50%
* Credit Notes  - 50%
* Taxes         - 100%
* Schedules     - 0%
* Sim. Invoices - 0%
* Purch. Orders - 90%

## Tests
=============

* Client        - 100%
* Sequences     - 0%
* Users         - 0%
* Invoices      - 0%
* Cash Invoices - 0%
* Items         - 0%
* Charts        - 100%
* Debit Notes   - 0%
* Credit Notes  - 0%
* Taxes         - 100%
* Schedules     - 60%
* Sim. Invoices - 0%
* Purch. Orders - 0%
 
Example
=============
If using from inside a rails project:
    require 'invoicexpress'
 
    client = Invoicexpress::Client.new(
      :screen_name => "yourusername",
      :api_key     => "yourapikey"
    )

    invoices  = client.invoices
    invoice   = client.invoice(1042320)
    chart  = client.treasury_chart

Dev
==============
if using inside the gem folder use:
    irb -Ilib -r./lib/invoicexpress

