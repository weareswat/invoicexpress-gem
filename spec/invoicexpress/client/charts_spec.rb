require 'helper'
describe Invoicexpress::Client::Charts do

  before do
    @client = Invoicexpress::Client.new(:screen_name => "thinkorangeteste")
  end

  describe ".invoicing_chart" do
    it "Returns the invoicing chart data." do
      stub_get("/invoicing.xml").
        to_return(xml_response("charts.invoicing.xml"))

      list = @client.invoicing_chart
      list.series.values.count == 6
      list.graphs.graph.values.count ==6
    end
  end

 

end
