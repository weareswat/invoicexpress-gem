require 'helper'

describe Invoicexpress::Client::Charts do

  before do
    @client = Invoicexpress::Client.new(:screen_name => "thinkorangeteste")
  end

  describe ".invoicing_chart" do
    it "Returns the invoicing chart data." do
      stub_get("/api/charts/invoicing.xml").
        to_return(xml_response("charts.invoicing.xml"))

      chart = @client.invoicing_chart
      chart.series.values.count.should == 6
      chart.graphs.first.values.count.should == 6
    end
  end

  describe ".treasury_chart" do
    it "Returns the treasury chart data." do
      stub_get("/api/charts/treasury.xml").
        to_return(xml_response("charts.treasury.xml"))

      chart = @client.treasury_chart
      #all there
      chart.series.values.count.should == 7
      #4 graphs
      chart.graphs.count.should ==4
      #count values
      chart.graphs.first.values.count.should ==7
      
    end
  end
  
  describe ".top_clients" do
    it "Returns the top 5 clients." do
       stub_get("/api/charts/top-clients.xml").
         to_return(xml_response("charts.top-clients.xml"))

       chart = @client.top_clients
       chart.clients.first.name.should =="Ruben Fonseca"
       chart.clients.size.should ==1
    end
  end
  
  describe ".top_debtors" do
    it "Returns the top 5 debtors." do
       stub_get("/api/charts/top-debtors.xml").
         to_return(xml_response("charts.top-debtors.xml"))

       chart = @client.top_debtors
       chart.clients.size.should ==1
       chart.clients.first.name.should =="Ruben Fonseca"
    end
  end

  describe ".quarterly_results" do
    it "return all the quarterly results." do
      stub_get("/api/charts/quarterly-results.xml?year=2010").
        to_return(xml_response("charts.quarterly-results.xml"))

      list = @client.quarterly_results({:year=>2010})
      list.quarter01.invoicing.should ==60.0
      list.year.should =="2010"
   end
  end
   
end
