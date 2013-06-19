require 'helper'

describe Invoicexpress::Client::SimplifiedInvoices do
  before do
    @client = Invoicexpress::Client.new(:screen_name => "thinkorangeteste")
  end

  describe ".simplified_invoices" do
    it "Returns all the simplified invoices" do
      stub_get("/simplified_invoices.xml?page=1").
        to_return(xml_response("simplified_invoices.list.xml"))

      items = @client.simplified_invoices
      items.count.should == 2
      items.first.id == 1425061
    end
  end

  describe ".create_simplified_invoice" do
    it "creates a new simplified invoice" do
      stub_post("/simplified_invoices.xml").
        to_return(xml_response("simplified_invoices.create.xml"))

      
      object = Invoicexpress::Models::SimplifiedInvoice.new(
        :date => Date.new(2013, 5, 1),
        :due_date => Date.new(2013, 6, 1),
        :tax_exemption => "M01",
        :client => Invoicexpress::Models::Client.new(
          :name => "Pedro Sousa"
        ),
        :items => [
          Invoicexpress::Models::Item.new(
            :name => "Item 1",
            :unit_price => 60,
            :quantity => 2,
            :unit => "unit",
          ),
          Invoicexpress::Models::Item.new(
            :name => "Item 2",
            :unit_price => 50,
            :quantity => 1,
            :unit => "unit",
          )
        ]
      )

      item = @client.create_simplified_invoice(object)
      item.id.should        == 1425061
      item.status           == "draft"
    end
  end

  describe ".simplified_invoice" do
    it "gets a simplified invoice" do
      stub_get("/simplified_invoices/1425061.xml").
        to_return(xml_response("simplified_invoices.get.xml"))

      item = @client.simplified_invoice(1425061)
      item.status.should == "settled"
      item.sequence_number.should == "1/2013"
    end
  end

  describe ".update_simplified_invoice" do
    it "updates the simplified invoice" do
      stub_put("/simplified_invoices/1425061.xml").
        to_return(xml_response("clients.update.xml"))

      model = Invoicexpress::Models::SimplifiedInvoice.new(:id => 1425061)
      expect { @client.update_simplified_invoice(model) }.to_not raise_error
    end
  end

  describe ".update_simplified_invoice_state" do
    it "updates the state" do
      stub_put("/simplified_invoices/1425061/change-state.xml").
        to_return(xml_response("simplified_invoices.update_state.xml"))

      state = Invoicexpress::Models::InvoiceState.new(
        :state => "finalized"
      )
      expect { item = @client.update_simplified_invoice_state(1425061, state) }.to_not raise_error
    end
  end
 
  describe ".simplified_invoice_mail" do
    it "sends the invoice through email" do
      stub_put("/simplified_invoices/1425061/email-document.xml").
        to_return(xml_response("simplified_invoices.email_document.xml"))

      message = Invoicexpress::Models::Message.new(
        :subject => "Hello world",
        :body => "Here is the invoice.",
        :client => Invoicexpress::Models::Client.new(
          :name => "Pedro Sousa",
          :email=> 'psousa@thinkorange.pt'
        )
      )
      expect {item = @client.simplified_invoice_mail(1425061, message) }.to_not raise_error
    end
  end
end
