# invoiceXpress GEM

Gem for invoicexpress API v1 at http://invoicexpress.com

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
* Invoices      - 80%
* Cash Invoices - 100%
* Items         - 100%
* Charts        - 100%
* Debit Notes   - 100%
* Credit Notes  - 100%
* Taxes         - 100%
* Schedules     - 100%
* Sim. Invoices - 100%
* Purch. Orders - 100%
* Invoice Receipts - 100%

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
* Inv. Receipts - 0%

## Documentation

We've included docs for all methods. Refer to the doc folder and client section.

## Testing locally

Run the tests from spec/ with

  rspec spec/


## Developing the gem further

Run the rake task

    rake console

to launch IRB with the gem loaded and you can use the following examples from the next section. If you want to use a proxy to inspect the requests you can use Postman, ex: http://blog.getpostman.com/2016/06/26/using-postman-proxy-to-capture-and-inspect-api-calls-from-ios-or-android-devices/

## Examples

If using from inside a rails project use:

    require 'invoicexpress'

    client = Invoicexpress::Client.new(
      screen_name: "yourusername",
      api_key:     "yourapikey",
      proxy: "192.168.1.201:5555"
    )

Examples for API are located in the EXAMPLES.md file.
