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
        @client.create_client(Invoicexpress::Models::Client.new())
      }.to raise_error(ArgumentError)
    end
  end

  describe ".get" do
    it "gets a client" do
      stub_get("/clients/1.xml").
        to_return(xml_response("clients.get.xml"))

      c = @client.client(1)
      c.name.should == "Bruce Norris"
      c.code.should == 1337
    end
  end

end
