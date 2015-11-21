require 'helper'

RSpec.describe Invoicexpress::Request do
  let (:path) { '' }
  let (:klass) { Class.new { include HappyMapper } }

  shared_examples 'an account_name validator' do
    context 'given a client with no account_name' do
      let (:client) { Invoicexpress.new }

      before do
        stub_request(:any, 'https://.app.invoicexpress.com/')
          .to_raise(Faraday::ConnectionFailed.new(
            'getaddrinfo: nodename nor servname provided, or not known'))
      end

      it 'raises a BadAddress error with a helpful suggestion' do
        expect { subject }.to raise_error(
          Invoicexpress::BadAddress, /forget.+account_name/)
      end
    end
  end

  describe '.delete' do
    subject (:delete) { client.delete path, klass: klass }
    it_behaves_like 'an account_name validator'
  end

  describe '.get' do
    subject (:get) { client.get path, klass: klass }
    it_behaves_like 'an account_name validator'
  end

  describe '.patch' do
    subject (:patch) { client.patch path, klass: klass }
    it_behaves_like 'an account_name validator'
  end

  describe '.post' do
    subject (:post) { client.post path, klass: klass }
    it_behaves_like 'an account_name validator'
  end

  describe '.put' do
    subject (:put) { client.put path, klass: klass }
    it_behaves_like 'an account_name validator'
  end
end
