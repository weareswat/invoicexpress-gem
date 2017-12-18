# Version 0.3.1
Added missing city field to client/customer model.

# Version 0.3.0
More big changes on this version:
- added logo option to send email
- added transport guides client
- set params_encoder = Faraday::FlatParamsEncoder in GET requests. We need this for the way that IX accepts arrays in GET requests. See https://github.com/lostisland/faraday/issues/78
- fixed missing owner_invoice_id, manual_sequence_number, currency_code, rate params on update credit note and debit note
- added models for address, message, transport guide
- added tests for transport guides

# Version 0.2.5
Big changes on this version:
- updated send email endpoint for invoices
- cleanup gemspec file
- started cleaning up test files from should to expect
- added manual_sequence_number field to invoices. Required for non portuguese accounts with manual sequence numbering.
- added saft_hash field to invoices
- added currency, multicurrency to invoices. not supported officially.
- added owner_invoice_id to credit_note. not working.

# Version 0.2.0
Support for 429 RateLimitExceeded code

# Version 0.1.9
Added Invoice Receipt

# Version 0.1.8
Added supplier model

# Version 0.1.7
Fix issue #7 - Wrong return type of Modes::Item#tax
Added Travis

# Version 0.1.6.1
Renamed the invoice_email method to email_invoice for sending email. Extracted examples to own file.

# Version 0.1.6
Fixed url for send email. New url: http://invoicexpress.com/api/invoices/email-invoice

# Version 0.1.5
Added rate to invoice. Experimental.

# Version 0.1.4.1
Added language field to client. API endpoint now defaults to https://%s.app.invoicexpress.com/

# Version 0.1.3
Removed "rquire 'pry'". Fixed it for production.

# Version 0.1.2
Corrected information in gem.

# Version 0.1.1
Fixed bug with latest version of Faraday (>0.9.0) which prevented creating a new client.

# Version 0.1.0
Release!
