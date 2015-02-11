require 'helper'

describe Invoicexpress::Client::Invoices do
  before do
    @client = Invoicexpress::Client.new(:screen_name => "thinkorangeteste")
  end

  describe ".invoices" do
    it "Returns all the invoice" do
      stub_get("/invoices.xml?page=1").
        to_return(xml_response("invoices.list.xml"))

      items = @client.invoices
      items.invoices.count.should == 10
      items.current_page==1
    end
  end

  describe ".create_invoice" do
    it "creates a new invoice" do
      stub_post("/invoices.xml").
        to_return(xml_response("invoices.create.xml"))

      
      object = Invoicexpress::Models::Invoice.new(
        :date => Date.new(2013, 6, 18),
        :due_date => Date.new(2013, 6, 18),
        :tax_exemption => "M01",
        :client => Invoicexpress::Models::Client.new(
          :name => "Ruben Fonseca"
        ),
        :items => [
          Invoicexpress::Models::Item.new(
            :name => "Item 1",
            :unit_price => 30,
            :quantity => 1,
            :unit => "unit",
          )
        ]
      )

      item = @client.create_invoice(object)
      item.id.should        == 1503698
      item.status           == "draft"
    end
  end

  describe ".invoice" do
    it "gets a invoice" do
      stub_get("/invoices/1503698.xml").
        to_return(xml_response("invoices.get.xml"))

      item = @client.invoice(1503698)
      item.status.should == "draft"
      item.client.id.should == 501854
    end
  end

  describe ".update_invoice" do
    it "updates the invoice" do
      stub_put("/invoices/1503698.xml").
        to_return(xml_response("ok.xml"))

      model = Invoicexpress::Models::Invoice.new(:id => 1503698)
      expect { @client.update_invoice(model) }.to_not raise_error
    end

    it "raises if no invoice is passed" do
      expect {
        @client.update_invoice(nil)
      }.to raise_error(ArgumentError)
    end

    it "raises if the simplified invoice to update has no id" do
      stub_put("/invoices/.xml").
        to_return(xml_response("ok.xml"))
      expect {
        @client.update_invoice(Invoicexpress::Models::SimplifiedInvoice.new)
      }.to raise_error(ArgumentError)
    end
  end
 
  describe ".update_invoice_state" do
    it "updates the state" do
      stub_put("/invoices/1503698/change-state.xml").
        to_return(xml_response("invoices.update_state.xml"))

      state = Invoicexpress::Models::InvoiceState.new(
        :state => "finalized"
      )
      expect { @client.update_invoice_state(1503698, state) }.to_not raise_error
    end
  end
 
  describe ".invoice_mail" do
    it "sends the invoice through email" do
      stub_put("/invoice/1503698/email-invoice.xml").
        to_return(xml_response("ok.xml"))
      message = Invoicexpress::Models::Message.new(
        :subject => "Hello world",
        :body => "Here is the invoice.",
        :client => Invoicexpress::Models::Client.new(
          :name => "Pedro Sousa",
          :email=> 'info@thinkorange.pt'
        )
      )
      expect { @client.invoice_mail(1503698, message) }.to_not raise_error
    end
  end
end
