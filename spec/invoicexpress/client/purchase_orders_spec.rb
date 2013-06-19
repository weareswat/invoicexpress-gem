require 'helper'

describe Invoicexpress::Client::PurchaseOrders do
  before do
    @client = Invoicexpress::Client.new(:screen_name => "thinkorangeteste")
  end

  describe ".purchase_orders" do
    it "Returns all the purchase orders" do
      stub_get("/purchase_orders.xml?page=1").
        to_return(xml_response("po.list.xml"))

      items = @client.purchase_orders
      items.count.should == 1
      items.first.id == 1430276
    end
  end

  describe ".create_purchase_order" do
    it "creates a new purchase order" do
      stub_post("/purchase_orders.xml").
        to_return(xml_response("po.create.xml"))
            
      object = Invoicexpress::Models::PurchaseOrder.new(
        :date => Date.new(2013, 5, 30),
        :due_date => Date.new(2013, 8, 8),
        :loaded_at => Date.new(2013, 5, 30),
        :delivery_site=>'LX Factory',
        :supplier => Invoicexpress::Models::Supplier.new(
          :name => "Pedro Sousa",
        ),
        :items => [
          Invoicexpress::Models::Item.new(
            :name => "Item 1",
            :unit_price => 60,
            :quantity => 2,
            :unit => "unit",
            :tax=> Invoicexpress::Models::Tax.new(
              :name=>'IVA23'
            )
          )
        ]
      )

      item = @client.create_purchase_order(object)
      item.id.should              == 1430276
      item.delivery_site.should   == "LX Factory"
    end
  end

  describe ".purchase_order" do
    it "gets a purchase order" do
      stub_get("/purchase_orders/1430276.xml").
        to_return(xml_response("po.get.xml"))

      item = @client.purchase_order(1430276)
      item.status.should == "draft"
      item.delivery_site.should == "LX Factory"
    end
  end

  describe ".update_purchase_order" do
    it "updates the purchase order" do
      stub_put("/purchase_orders/1430276.xml").
        to_return(xml_response("clients.update.xml"))

      model = Invoicexpress::Models::PurchaseOrder.new(:id => 1430276)
      expect { @client.update_purchase_order(model) }.to_not raise_error
    end
  end

  describe ".update_purchase_order_state" do
    it "updates the state" do
      stub_put("/purchase_orders/1430338/change-state.xml").
        to_return(xml_response("po.update_state.xml"))

      state = Invoicexpress::Models::InvoiceState.new(
        :state => "finalized"
      )

      expect { item = @client.update_purchase_order_state(1430338, state) }.to_not raise_error
    end
  end
 
  describe ".simplified_invoice_mail" do
    it "sends the invoice through email" do
      stub_put("/purchase_orders/1430338/email-document.xml").
        to_return(xml_response("po.email_document.xml"))

      message = Invoicexpress::Models::Message.new(
        :subject => "Hello world",
        :body => "Here is the invoice.",
        :client => Invoicexpress::Models::Client.new(
          :name => "Pedro Sousa",
          :email=> 'psousa@thinkorange.pt'
        )
      )
      expect {item = @client.purchase_order_mail(1430338, message) }.to_not raise_error
    end
  end
end
