require 'helper'

describe Invoicexpress::Client::TransportGuides do
  before do
    @client = Invoicexpress::Client.new(:screen_name => "thinkorangeteste")
  end


  describe ".transport_guides" do
    it "Returns all the transport guides" do
      stub_get("/transports.xml?non_archived=true&page=1&status%5B%5D=canceled&status%5B%5D=draft&status%5B%5D=second_copy&status%5B%5D=sent&type%5B%5D=Transport").to_return(xml_response("transports.list.xml"))

      documents = @client.transport_guides

      expect(documents.transports.first.class).to eq Invoicexpress::Models::TransportGuide
      expect(documents.transports.first.id).to eq 12539316
      expect(documents.transports.count).to eq 2
      expect(documents.total_pages).to eq 1
      expect(documents.total_entries).to eq 2
    end

    it "Returns transport guides with filter" do
      stub_get("/transports.xml?non_archived=true&page=1&status%5B%5D=canceled&status%5B%5D=draft&status%5B%5D=second_copy&status%5B%5D=sent&type%5B%5D=Transport&text=RVD").to_return(xml_response("transports.filter.xml"))

      documents = @client.transport_guides text: "RVD"

      expect(documents.transports.first.id).to eq 12531848
      expect(documents.transports.count).to eq 1
      expect(documents.total_pages).to eq 1
      expect(documents.total_entries).to eq 1
    end
  end

  describe ".transport_guide" do
    it "Returns transport information" do
      stub_get("/transports/12531848.xml").to_return(xml_response("transports.get.xml"))
      document = @client.transport_guide(12531848)

      expect(document.id).to eq 12531848
      expect(document.archived).to eq "false"
      expect(document.date.to_s).to eq "2017-05-16"
      expect(document.client.name).to eq "Peter Parker"
      expect(document.address_to.city).to eq "Lisboa"
      expect(document.address_from.city).to eq "Porto"
      expect(document.address_from.country).to eq "Portugal"
      expect(document.items.size).to eq 1
      expect(document.total).to eq 35.0
    end

    it "Returns currency information" do
      stub_get("/transports/12531848.xml").to_return(xml_response("transports.get.xml"))
      document = @client.transport_guide(12531848)

      expect(document.currency).to eq "Euro"
      expect(document.total).to eq 35.0
      expect(document.multicurrency.rate).to eq 1.1014
      expect(document.multicurrency.currency).to eq "USD"
      expect(document.multicurrency.total).to eq 38.55
    end
  end

  describe ".create_transport_guide" do
    it "creates a new transport guide" do
      stub_post("/transports.xml").to_return(xml_response("transports.create.xml"))

      obj = Invoicexpress::Models::TransportGuide.new(
        :date => Date.new(2017, 5, 17),
        :due_date => Date.new(2017, 5, 17),
        :loaded_at => DateTime.new(2017, 5, 18, 8,37,48),
        :tax_exemption => "M01",
        :license_plate => "KITT",
        #:reference => "007",
        :address_from => Invoicexpress::Models::AddressFrom.new(
          :detail => "From Address",
          :city => "Lisbon",
          :postal_code => "1300-501",
          :country => "Portugal"
        ),
        :address_to => Invoicexpress::Models::AddressTo.new(
          :detail => "To Address",
          :city => "Lisbon",
          :postal_code => "1300-501",
          :country => "Portugal"
        ),
        :client => Invoicexpress::Models::Client.new(
          :name => "Peter Parker",
          :code => "5239"
        ),
        :items => [
          Invoicexpress::Models::Item.new(
            :name => "Item 1",
            :unit_price => 60,
            :quantity => 2
          ),
          Invoicexpress::Models::Item.new(
            :name => "Item 2",
            :unit_price => 50,
            :quantity => 1
          )
        ]
      )
      document = @client.create_transport_guide(obj)

      expect(document.id).to eq 12544003
      expect(document.status).to eq "draft"
      expect(document.archived).to eq "false"
      expect(document.address_from.city).to eq "Lisbon"
      expect(document.address_to.detail).to eq "To Address"
      expect(document.total).to eq 170.0

    end
  end

  describe ".update_transport_guide" do
    it "updates the transport guide" do
      stub_put("/transports/12544003.xml").to_return(xml_response("ok.xml"))

      model = Invoicexpress::Models::TransportGuide.new(:id => 12544003)
      expect { @client.update_transport_guide(model) }.to_not raise_error
    end
    it "raises if no transport is passed" do
      expect {
        @client.update_transport_guide(nil)
      }.to raise_error(ArgumentError)
    end
    it "raises if the doc to update has no id" do
      stub_put("/transports/.xml").to_return(xml_response("ok.xml"))
      expect {
        @client.update_transport_guide(Invoicexpress::Models::TransportGuide.new)
      }.to raise_error(ArgumentError)
    end
  end
  #
  describe ".update_credit_note_state" do
    it "updates the state" do
      stub_put("/transports/12544123/change-state.xml").to_return(xml_response("transports.change_state.xml"))

      state = Invoicexpress::Models::InvoiceState.new(
        :state => "finalized"
      )
      expect { document = @client.update_transport_guide_state(12544123, state) }.to_not raise_error
    end
  end
  #
  describe ".email_transport_guide" do
    it "sends the document through email" do
      stub_put("/transports/12531848/email-document.xml").
        to_return(xml_response("transports.email_document.xml"))


      message = Invoicexpress::Models::Message.new(
        :subject => "Hello world",
        :body => "Here is cenas.",
        :logo => 1,
        :client => Invoicexpress::Models::Client.new(
          :name => "Peter Parker",
          :email=> 'psousa@thinkorange.pt'
        )
      )
      expect { document = @client.email_transport_guide(12531848, message) }.to_not raise_error
    end
  end
end
