require 'helper'

describe Invoicexpress::Client::CreditNotes do
  before do
    @client = Invoicexpress::Client.new(:screen_name => "thinkorangeteste")
  end

  describe ".credit_notes" do
    it "Returns all the credit notes" do
      stub_get("/credit_notes.xml?page=1").
        to_return(xml_response("credit_notes.list.xml"))

      credit_notes = @client.credit_notes
      credit_notes.count.should == 2
      credit_notes.first.id == 1415679
    end
  end

  describe ".create_credit_note" do
    it "creates a new credit note" do
      stub_post("/credit_notes.xml").
        to_return(xml_response("credit_notes.create.xml"))

      
      cnote = Invoicexpress::Models::CreditNote.new(
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

      cnote = @client.create_credit_note(cnote)
      cnote.id.should        == 1423940
      cnote.status           == "draft"
    end
  end

  
  describe ".update_credit_note_state" do
    it "updates the state" do
      stub_put("/credit_notes/1423940/change-state.xml").
        to_return(xml_response("credit_notes.update_state.xml"))

      state = Invoicexpress::Models::InvoiceState.new(
        :state => "finalized"
      )
      expect { cnote = @client.update_credit_note_state(1423940, state) }.to_not raise_error
    end
  end
 
  describe ".credit_note_mail" do
    it "sends the credit note through email" do
      stub_put("/credit_notes/1423940/email-document.xml").
        to_return(xml_response("credit_notes.email_document.xml"))

      message = Invoicexpress::Models::Message.new(
        :subject => "Hello world",
        :body => "Here is the invoice.",
        :client => Invoicexpress::Models::Client.new(
          :name => "Pedro Sousa",
          :email=> 'psousa@thinkorange.pt'
        )
      )
      expect { cnote = @client.credit_note_mail(1423940, message) }.to_not raise_error
    end
  end
end
