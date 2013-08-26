require 'helper'

describe Invoicexpress::Client::Sequences do
  before do
    @client = Invoicexpress::Client.new(:screen_name => "thinkorangeteste")
  end

  describe ".sequences" do
    it "Returns all the sequences" do
      stub_get("/sequences.xml").
        to_return(xml_response("sequences.list.xml"))

      list = @client.sequences
      list.count.should == 1
      list.first.id == 230568
      list.first.current_invoice_number==1
    end
  end

  describe ".sequence" do
    it "gets a sequence" do
      stub_get("/sequences/230568.xml").
        to_return(xml_response("sequences.get.xml"))

      c = @client.sequence(230568)
      c.id.should == "230568"
      c.serie.should == "2013"
    end
  end

  describe ".create_sequence" do
    it "creates a new sequence" do
      stub_post("/sequences.xml").
        to_return(xml_response("sequences.create.xml"))

      seq = Invoicexpress::Models::Sequence.new({
        :serie => "2099",
        :current_invoice_number => 100,
        :current_credit_note_number => 200,
        :current_debit_note_number => 300,
        :default_sequence => 0
      })

      new_object = @client.create_sequence(seq)
      new_object.serie.should == "2099"
      new_object.current_invoice_number.should == 100
    end
  end

  describe ".update_sequence" do
    it "updates the sequence" do
      stub_put("/sequences/266500.xml").
        to_return(xml_response("sequences.update.xml"))

      model = Invoicexpress::Models::Sequence.new({
        :id=>'266500',
        :serie => "2098",
        :current_invoice_number => 100,
        :current_credit_note_number => 200,
        :current_debit_note_number => 300,
        :default_sequence => 0
      })

      expect { @client.update_sequence(model) }.to_not raise_error
    end
  end
end

