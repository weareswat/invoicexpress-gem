require 'helper'

describe Invoicexpress::Client do
  before do
    Invoicexpress.reset
  end

  describe "api_endpoint" do
    after(:each) do
      Invoicexpress.reset
    end

    it "defaults to https://%s.app.invoicexpress.com/" do
      client = Invoicexpress::Client.new

      expect(client.api_endpoint).to eq "https://%s.app.invoicexpress.com/"
    end

    it "is set" do
      Invoicexpress.api_endpoint = "https://thinkorangeteste.app.invoicexpress.com/"
      client = Invoicexpress::Client.new

      expect(client.api_endpoint).to eq "https://thinkorangeteste.app.invoicexpress.com/"
    end
  end
end
