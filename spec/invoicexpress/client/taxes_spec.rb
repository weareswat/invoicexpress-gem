require 'helper'

describe Invoicexpress::Client::Taxes do
  before do
    @client = Invoicexpress::Client.new(:screen_name => "thinkorangeteste")
  end

  describe ".taxes" do
    it "Returns all the taxes" do
      stub_get("/taxes.xml").
        to_return(xml_response("taxes.list.xml"))

      taxes = @client.taxes
      taxes.count.should == 2
    end
  end

  describe ".create_tax" do
    it "creates a new tax" do
      stub_post("/taxes.xml").
        to_return(xml_response("taxes.create.xml"))

      model_tax = Invoicexpress::Models::Tax.new({
        :name        => "IVA19",
        :value       => 19.0,
        :region      => "PT",
        :default_tax => 1
      })

      tax = @client.create_tax(model_tax)
      tax.name.should        == "IVA19"
      tax.value.should       == 19.0
      tax.region.should      == "PT"
      tax.default_tax.should == 1
    end

    it "raises if no tax is passed" do
      expect {
        @client.create_tax(nil)
      }.to raise_error(ArgumentError)
    end
  end

  describe ".update_tax" do
    it "updates a tax" do
      stub_put("/taxes/123.xml").
        to_return(xml_response("taxes.update.xml"))

      model = Invoicexpress::Models::Tax.new({
        :id    => 123,
        :name  => "IVA23",
        :value => 23.0
      })

      tax = @client.update_tax(model)
      tax.name.should   == "IVA23"
      tax.value.should  == 23.0
      tax.region.should == "PT"
    end
  end

  describe ".delete_tax" do
    it "should delete a tax without errors" do
      stub_delete("/taxes/123.xml").to_return(empty_xml_response)

      expect { @client.delete_tax(123) }.to_not raise_error
    end
  end

end
