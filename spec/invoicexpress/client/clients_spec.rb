require 'helper'

describe Invoicexpress::Client::Clients do

  before do
    @client = Invoicexpress::Client.new(:screen_name => "thinkorangeteste")
  end

  describe ".clients" do
    it "returns all the clients" do
      stub_get("/clients.xml?per_page=30&page=1").
        to_return(xml_response("clients.list.xml"))

      list = @client.clients
      list.count.should == 1
      list.first.name.should == "Ruben Fonseca"
      list.first.email.should == "fonseka@gmail.com"
    end
  end

  describe ".create_client" do
    it "creates a new client" do
      stub_post("/clients.xml").
        to_return(xml_response("clients.create.xml"))

      model_client = Invoicexpress::Models::Client.new({
        :name => "Ruben Fonseca",
        :email => "fonseka@gmail.com"
      })

      new_client = @client.create_client(model_client)
      new_client.name.should == "Ruben Fonseca"
      new_client.email.should == "fonseka@gmail.com"
    end

    it "raises if no client is passed" do
      expect {
        @client.create_client(nil)
      }.to raise_error(ArgumentError)
    end

    it "raises if the client has no name" do
      expect {
        @client.create_client(Invoicexpress::Models::Client.new)
      }.to raise_error(ArgumentError)
    end
  end

  describe ".update_client" do
    it "updates the client" do
      stub_put("/clients/123.xml").
        to_return(xml_response("clients.update.xml"))

      model = Invoicexpress::Models::Client.new(:id => 123)

      expect { @client.update_client(model) }.to_not raise_error
    end

    it "raises if no client is passed" do
      expect {
        @client.update_client(nil)
      }.to raise_error(ArgumentError)
    end

    it "raises if the client to update has no id" do
      expect {
        @client.update_client(Invoicexpress::Models::Client.new)
      }.to raise_error(ArgumentError)
    end
  end

  describe ".client" do
    it "gets a client" do
      stub_get("/clients/1.xml").
        to_return(xml_response("clients.get.xml"))

      c = @client.client(1)
      c.name.should == "Bruce Norris"
      c.code.should == 1337
    end
  end

  describe ".client_invoices" do
    it "gets the client's invoices" do
      stub_post("/clients/1/invoices.xml").
        to_return(xml_response("clients.invoices.xml"))

      invoices = @client.client_invoices(1)
      invoices.results.entries.should == 0
      invoices.results.total_entries == 0
    end

    it "gets the client's invoices with filters" do
      filter = Invoicexpress::Models::Filter.new({
        :status   => [:draft, :final],
        :by_type  => ["Receipt"],
        :archived => [:non_archived]
      })

      stub_post("/clients/1/invoices.xml").
        to_return(xml_response("clients.invoices.xml"))

      invoices = @client.client_invoices(1, filter)
      invoices.results.entries.should == 0
    end
  end

end
