require 'helper'

describe Invoicexpress::Client::Invoices do
  before do
    @client = Invoicexpress::Client.new(:account_name => "thinkorangeteste")
  end

  describe ".invoices" do
    it "Returns all the invoice" do
      stub_get("/invoices.xml?page=1").
        to_return(xml_response("invoices.list.xml"))

      items = @client.invoices

      expect(items.invoices.count).to eq 10
      expect(items.current_page).to eq 1
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

      expect(item.id).to eq 1503698
      expect(item.status).to eq "draft"
    end

    it "creates a new invoice with currency" do
      stub_post("/invoices.xml").
        to_return(xml_response("invoices.create_usd.xml"))

        object = Invoicexpress::Models::Invoice.new(
          :date => Date.new(2017, 5, 16),
          :due_date => Date.new(2017, 5, 16),
          :tax_exemption => "M08",
          :status=> "draft",
          :client => Invoicexpress::Models::Client.new(
            :name => "Peter Parker"
          ),
          :currency_code=> "USD_$",
          :rate => 1.09,
          :items => [
            Invoicexpress::Models::Item.new(
              :name => "Poster 1",
              :unit_price => 30,
              :quantity => 1,
              :unit => "unit",
            ),
            Invoicexpress::Models::Item.new(
              :name => "Poster 2",
              :unit_price => 10,
              :quantity => 1,
              :unit => "unit",
            )
          ]
        )

      item = @client.create_invoice(object)

      expect(item.id).to eq 12530575
      expect(item.multicurrency.rate).to eq 1.09
      expect(item.multicurrency.currency).to eq "USD"
      expect(item.multicurrency.total).to eq 43.6
    end

    context 'given an invoice with mb_reference set to true' do
      let (:invoice) do
        Invoicexpress::Models::Invoice.new(
          :date => Date.new(2013, 6, 18),
          :due_date => Date.new(2013, 6, 18),
          :tax_exemption => "M01",
          :mb_reference => true,
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
      end

      before do
        stub_post("/invoices.xml").
          to_return(xml_response("invoices.create.xml"))
      end

      it 'creates a draft invoice' do
        item = @client.create_invoice(invoice)
        item.id.should        == 1503698
        item.status           == "draft"
      end

      it 'sends mb_reference only once in the payload' do
        @client.create_invoice(invoice)
        expect(a_request(:post, /.+invoices.xml$/).with do |req|
          req.body.scan(/<mb_reference>true<\/mb_reference>/).length == 1
        end).to have_been_made.once
      end
    end

  end

  describe ".invoice" do
    it "gets a invoice" do
      stub_get("/invoices/1503698.xml").
        to_return(xml_response("invoices.get.xml"))

      item = @client.invoice(1503698)

      expect(item.status).to eq "draft"
      expect(item.client.id).to eq 501854
      expect(item.before_taxes).to eq 30.0
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

  describe ".email_invoice" do
    it "sends the invoice through email" do
      stub_put("/invoices/1503698/email-document.xml").
        to_return(xml_response("ok.xml"))
      message = Invoicexpress::Models::Message.new(
        :subject => "Hello world",
        :body => "Here is the invoice.",
        :client => Invoicexpress::Models::Client.new(
          :name => "Pedro Sousa",
          :email=> 'info@thinkorange.pt'
        )
      )
      expect { @client.email_invoice(1503698, message) }.to_not raise_error
    end
  end
end
