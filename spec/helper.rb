require 'simplecov'

if ENV['COVERAGE']
  SimpleCov.start do
    add_filter "/spec"
  end
end

require 'invoicexpress'
require 'rspec'
require 'webmock/rspec'

