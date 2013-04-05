invoiceXpress
=============

Gem for invoicexpress API
reference: http://en.invoicexpress.com/api/appendix/clients-country-list/

Dependencies
=============

Run bundle, the project should need:
Happymapper
Faraday
And pretzels!

Progress
=============

Client        - 100%
Sequences     - 100%
Users         - 100%
Invoices      - 100%
Cash Invoices - 100%
Credit Notes  - 100%
Items         - 100%
Charts        - 100%
Taxes         - 0%
Schedules     - 0%

Tests
=============

Client - 100%
Charts - 100%

Example
=============
if using inside the gem folder use:
irb -Ilib -r./lib/invoicexpress
if using from inside a rails project:
require 'invoicexpress'
 
client = Invoicexpress::Client.new(
  :screen_name => "yourusername",
  :api_key     => "yourapikey",
)

invoices  = client.invoices
invoice   = client.invoice(1042320)
chart  = client.treasury_chart
