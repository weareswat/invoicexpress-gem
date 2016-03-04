# Version 0.1.9.1
Fixed problem with duplicated mb_reference

# Version 0.1.8
Added city field to client.

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
