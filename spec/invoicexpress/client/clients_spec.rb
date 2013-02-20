require 'helper'

describe Invoicexpress::Client::Clients do

  before do
    @client = Invoicexpress::Client.new(:screen_name => "thinkorangeteste")
  end

  describe ".list" do
    it "returns all the clients" do
      stub_get("/clients.xml?per_page=30&page=1").
        to_return(xml_response("clients.list.xml"))

      list = @client.list
      list.count.should == 1
      list.first.name.should == "Ruben Fonseca"
      list.first.email.should == "fonseka@gmail.com"
    end
  end

  describe ".create" do
    it "creates a new client" do
      stub_post("/clients.xml").
        to_return(xml_response("clients.create.xml"))

      model_client = Invoicexpress::Models::Client.new({
        :name => "Ruben Fonseca",
        :email => "fonseka@gmail.com"
      })

      new_client = @client.create(model_client)
      new_client.name.should == "Ruben Fonseca"
      new_client.email.should == "fonseka@gmail.com"
    end
  end

end
