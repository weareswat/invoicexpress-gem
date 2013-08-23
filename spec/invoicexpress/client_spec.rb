require 'helper'

describe Invoicexpress::Client do
  before do
    Invoicexpress.reset
  end

  describe "api_endpoint" do
    after(:each) do 
      Invoicexpress.reset
    end

    it "defauls to https://%s.invoicexpress.net" do
      client = Invoicexpress::Client.new
      client.api_endpoint.should == "https://%s.invoicexpress.net/"
    end

    it "is set" do
      Invoicexpress.api_endpoint = "https://thinkorangeteste.invoicexpress.net/"
      client = Invoicexpress::Client.new
      client.api_endpoint.should == "https://thinkorangeteste.invoicexpress.net/"
    end
  end
end
